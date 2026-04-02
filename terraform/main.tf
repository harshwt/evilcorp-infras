provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "evilcorp_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name        = "evilcorp-production"
    Environment = "prod"
    CostCenter  = "INFRA-001"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.evilcorp_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "evilcorp-private"
  }
}

resource "aws_security_group" "internal" {
  name   = "evilcorp-internal"
  vpc_id = aws_vpc.evilcorp_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
