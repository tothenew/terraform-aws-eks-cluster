data "aws_vpc" "default" {
  default = true
}

# data "aws_subnet_ids" "default" {
#   vpc_id = aws_vpc.default.id
# }

locals {
  cluster_sg_name           = coalesce(var.cluster_security_group_name, "${var.cluster_name}")
  cluster_security_group_id = var.cluster_security_group_id != "" ? aws_security_group.this[0].id : var.cluster_security_group_id

  cluster_security_group_rules = {
    ingress_nodes_443 = {
      description                = "Node groups to cluster API"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "ingress"
      source_node_security_group = true
    }
    egress_nodes_443 = {
      description                = "Cluster API to node groups"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "egress"
      source_node_security_group = true
    }
    egress_nodes_kubelet = {
      description                = "Cluster API to node kubelets"
      protocol                   = "tcp"
      from_port                  = 10250
      to_port                    = 10250
      type                       = "egress"
      source_node_security_group = true
    }
  }
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.this.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.cluster_subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
    security_group_ids      = distinct(concat(var.cluster_additional_security_group_ids, [local.cluster_security_group_id]))
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
    ip_family         = var.ip_family
  }

  timeouts {
    create = var.cluster_create_timeout
    update = var.cluster_update_timeout
    delete = var.cluster_delete_timeout
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types
  depends_on = [
    aws_iam_role_policy_attachment.ClusterPolicy,
    aws_iam_role_policy_attachment.VPCResourceControllerPolicy,
  ] 
}

resource "aws_iam_role" "this" {
  name = var.cluster_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "ClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.this.name
}


resource "aws_iam_role_policy_attachment" "VPCResourceControllerPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.this.name
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create_cloudwatch_log_group ? 1 : 0

  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.cloudwatch_log_group_log_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_id
}

resource "aws_security_group" "this" {
  count = var.create_cluster_security_group ? 1 : 0

  name        = var.cluster_security_group_use_name_prefix ? null : local.cluster_sg_name
  name_prefix = var.cluster_security_group_use_name_prefix ? "${local.cluster_sg_name}" : null
  description = var.cluster_security_group_description
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in merge(local.cluster_security_group_rules, var.cluster_security_group_additional_rules) : k => v if var.create_cluster_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  type              = each.value.type

  # Optional
  description      = try(each.value.description, null)
  cidr_blocks      = try(each.value.cidr_blocks, null)
  ipv6_cidr_blocks = try(each.value.ipv6_cidr_blocks, null)
  prefix_list_ids  = try(each.value.prefix_list_ids, [])
  self             = try(each.value.self, null)
  source_security_group_id = try(
    each.value.source_security_group_id,
    try(each.value.source_node_security_group, false) ? var.node_security_group_id : null
  )
}
