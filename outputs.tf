output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = aws_eks_cluster.this.arn
}

output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = aws_eks_cluster.this.id
}

output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = aws_eks_cluster.this.status
}

output "cluster_platform_version" {
  description = "Platform version for the cluster"
  value       = try(aws_eks_cluster.this.platform_version, "")
}

output "cluster_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the cluster security group"
  value       = try(aws_security_group.this[0].arn, "")
}

output "cluster_security_group_id" {
  description = "ID of the cluster security group"
  value       = try(aws_security_group.this[0].id, "")
}