# AWS EKS Cluster Terraform module
This terraform module creates AWS EKS cluster.

## How To Use Terraform Module for creating eks cluster?

### eks-cluster-module-with-custom-inputs

```
module "terraform-aws-eks-cluster" {
  source  = "../terraform-aws-eks-cluster"
  cluster_name = "eks-cluster"
  cluster_version = "1.23"
  cluster_role_name = "eks-cluster-role"
  cluster_subnet_ids = ["subnet-a", "subnet-b", "subnetc"]
  cluster_endpoint_private_access = false  
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  vpc_id = "vpc-1234556abcdef"
  cluster_service_ipv4_cidr = "172.20.0.0/16"
  ip_family = "ipv4"
  create_cloudwatch_log_group = true
  cloudwatch_log_group_log_retention_in_days = 90
  create_cluster_security_group = true
  cluster_additional_security_group_ids = []
  cluster_security_group_description = "EKS cluster security group"
  cluster_security_group_name = "eks-cluster-sg"
  cluster_security_group_use_name_prefix = true
  environment = "dev"
  project = "eks-dev"
} 
```





### eks-cluster-with-minimum-inputs
```
module "terraform-aws-eks-cluster" {
  source  = "../terraform-aws-eks-cluster"
  cluster_subnet_ids = ["subnet-4a57cc07"]
} 
```

### eks-cluster-with-private-access
```
module "terraform-aws-eks-cluster" {
  source  = "../terraform-aws-eks-cluster"
  cluster_subnet_ids = ["subnet-4a57cc07"]
  cluster_endpoint_private_access = true
}
```




