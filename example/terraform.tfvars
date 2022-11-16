region              = "us-east-1"
profile             = "tothenew"
project_name_prefix = "tothenew"
common_tags = {
  "Feature" : "application"
}
project                                    = "tothenew"
cluster_security_group_name                = "eks_cluster_sg"
cluster_security_group_id                  = "" #Please enter the sg ID if you have a security group already created
cluster_name                               = "eks-cluster"
cluster_version                            = "1.22"
cluster_endpoint_private_access            = "true"
cluster_endpoint_public_access             = "false"
enabled_cluster_log_types                  = ["controllerManager", "api", "scheduler"]
cluster_role_name                          = "eks_cluster_role"
cloudwatch_log_group_log_retention_in_days = "90"
cloudwatch_log_group_kms_id                = null  #You can define your customer managed KMS key ID if not default
create_cluster_security_group              = false #You can create security group having ports 443 and 10250 accessible
create_eks_iam_role                        = false
cluster_role_arn                           = "" #Required, in case an external role is to be attached to EKS Cluster
vpc_id                                     = ""
node_security_group_id                     = "" #Required, in case this module is creating security group for your cluster
