provider "aws" {
  region = var.region
}

# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"   # pin stable version

  name    = "devops-vpc"
  cidr    = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
}

# EKS Module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"   # this pins the Terraform module version

  cluster_name    = "devops-cluster"   # correct argument for cluster name
  cluster_version = "1.29"             # correct argument for Kubernetes version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets   # correct argument for subnets

  cluster_endpoint_public_access = true
}

# Jenkins EC2 Instance
resource "aws_instance" "jenkins" {
  ami                         = var.ami_id
  instance_type               = "t3.medium"
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data                   = file("${path.module}/jenkins-install.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}
