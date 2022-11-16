module "eks_cluster" {
  source                      = "git@github.com:tothenew/terraform-aws-eks-cluster.git"
  cluster_security_group_name = var.cluster_security_group_name
  cluster_security_group_id   = var.cluster_security_group_id

  #  cluster_additional_security_group_ids = var.cluster_additional_security_group_ids
  cluster_name                               = "${local.project_name_prefix}-${var.cluster_name}"
  cluster_version                            = var.cluster_version
  cluster_subnet_ids                         = [var.cluster_subnet_ids]
  cluster_endpoint_private_access            = var.cluster_endpoint_private_access
  cluster_endpoint_public_access             = var.cluster_endpoint_public_access
  create_eks_iam_role                        = var.create_eks_iam_role
  cluster_role_arn                           = var.cluster_role_arn
  enabled_cluster_log_types                  = var.enabled_cluster_log_types
  cluster_role_name                          = var.cluster_role_name
  cloudwatch_log_group_log_retention_in_days = var.cloudwatch_log_group_log_retention_in_days
  cloudwatch_log_group_kms_id                = var.cloudwatch_log_group_kms_id
  vpc_id                                     = var.vpc_id
  create_cluster_security_group              = var.create_cluster_security_group
  node_security_group_id                     = var.node_security_group_id
  environment                                = terraform.workspace
  project                                    = var.project
  tags = merge(local.common_tags,
    tomap({ "Name" : "${local.project_name_prefix}-cluster-${replace(var.cluster_version, ".", "-")}" })
  )
}
