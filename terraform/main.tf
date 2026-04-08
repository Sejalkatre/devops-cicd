provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "devops-vpc"
  cidr    = "10.0.0.0/16"
  azs     = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "devops-cluster"
  cluster_version = "1.29"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
}

resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = "t3.medium"
  subnet_id     = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name      = var.key_name
  user_data     = file("${path.module}/jenkins-install.sh")
  tags = { Name = "Jenkins-Server" }
}
