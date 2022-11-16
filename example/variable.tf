variable "project" {
  description = "Environment Tag value"
  type        = string
}

variable "lt_name" {
  description = "The name of the launch template. If blank, Terraform will auto-generate a unique name."
  type        = string
}

#variable "vpc_security_group_ids" {
#  description = "List of security group IDs to associate the Node Group with."
#  type        = list(string)
#}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
  #type = list
  default = ["subnet-99999999999", "subnet-99999999999", "subnet-99999999999"]
}

variable "region" {
  type        = string
  description = "A string value for Launch resources in which AWS Region"
}

variable "profile" {
  type        = string
  description = "A string value for setting AWS Profile"
}

variable "project_name_prefix" {
  type        = string
  description = "A string value to describe prefix of all the resources"
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
}

variable "cluster_version" {
  description = "Kubernetes version to be used for creatimg the EKS cluster."
  type        = string
  default     = "1.22"
}

variable "cluster_role_name" {
  description = "Name of the EKS cluster role"
  default     = "eks-cluster-role"
  type        = string
}

variable "cluster_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster node groups (ENIs) will be provisioned."
  default     = []
  type        = list(string)
}

variable "enabled_cluster_log_types" {
  description = "A list of the desired control plane logs to enable."
  type        = list(string)
  default     = ["audit", "api", "authenticator"]
}

variable "cluster_endpoint_private_access" {
  description = "Whether the Amazon EKS private API server endpoint is enabled. Default is false."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled. Default is true."
  type        = bool
  default     = false
}

#variable "cluster_endpoint_public_access_cidrs" {
#  description = "Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0."
#  type        = list(string)
#  default     = ["0.0.0.0/0"]
#}

variable "vpc_id" {
  description = "ID of the VPC where the cluster and its nodes will be provisioned"
  type        = string
  default     = null
}

variable "cluster_service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks. Refer terraform doc for understanding requirements that the CIDR Block should meet."
  type        = string
  default     = null
}

variable "ip_family" {
  description = "The IP family used to assign Kubernetes pod and service addresses. Valid values are ipv4 (default) and ipv6. You can only specify an IP family when you create a cluster, changing this value will force a new cluster to be created."
  type        = string
  default     = null
}

variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_log_retention_in_days" {
  description = "Number of days to retain log events."
  type        = number
  default     = 90
}

variable "cloudwatch_log_group_kms_id" {
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. The KMS Key must have an appropriate key policy"
  type        = string
  default     = null
}

variable "create_cluster_security_group" {
  description = "Set True if security group needs to be created for the cluster or use the existing `cluster_security_group_id`"
  type        = bool
  default     = false
}

variable "cluster_security_group_id" {
  description = "Existing security group ID to be attached to the cluster. Needs a value if you don't want the default security to be created using terraform."
  type        = string
  default     = ""
}

#variable "cluster_additional_security_group_ids" {
#  description = "List of additional, externally created security group IDs to attach to the cluster control plane"
#  type        = list(string)
#  default     = []
#}

variable "cluster_security_group_name" {
  description = "Name to use on cluster security group created"
  type        = string
  default     = null
}

variable "cluster_security_group_use_name_prefix" {
  description = "Determines whether cluster security group name (`cluster_security_group_name`) is used as a prefix"
  type        = string
  default     = true
}

variable "cluster_security_group_additional_rules" {
  description = "List of additional security group rules to add to the cluster security group created"
  type        = any
  default     = {}
}

variable "create_eks_iam_role" {
  description = "Node Security Group ID"
  type        = bool
  default     = false
}

variable "cluster_role_arn" {
  description = "Determines whether iam role arn is created by this module for the cluster. If not, AWS will automatically create one if logging is enabled"
  type        = string
  default     = ""
}

variable "node_security_group_id" {
  description = "Node Security Group ID"
  type        = string
  default     = ""
}
