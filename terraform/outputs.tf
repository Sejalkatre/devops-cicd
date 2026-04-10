output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "eks_cluster_name" {
  value = module.eks.cluster.name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster.endpoint
}

output "eks_cluster_version" {
  value = module.eks.cluster.version
}
