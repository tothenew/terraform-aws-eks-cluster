variable "cluster_name" {
  default = "eks-cluster"
  type    = string
}

variable "cluster_role_name" {
  default = "eks-cluster-role"
  type    = string
}

variable "cluster_subnet_ids" {
  default = []
  type    = list(any)
}
