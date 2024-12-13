provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "test-vpc" {
  cidr_block = "172.0.1.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_security_group" "eks" {
  name        = "eks-security-group"
  description = "Allow communication between nodes and the control plane"
  vpc_id      = aws_vpc.main.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }
}

resource "aws_eks_cluster" "test" {
  name     = "test-cluster"
  role_arn = aws_iam_role.eks.arn
  vpc_config {
    subnet_ids = aws_subnet.main.*.id
  }
}

resource "aws_iam_role" "eks" {
  name = "eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Effect    = "Allow"
      Sid       = ""
    }]
  })
}

resource "aws_subnet" "main" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

