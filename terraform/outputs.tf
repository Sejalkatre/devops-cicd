# Public IP of Jenkins EC2
output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

# EKS Cluster Outputs (v20.x schema)
output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_version" {
  value = module.eks.cluster_version
}
