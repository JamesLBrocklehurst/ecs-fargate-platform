module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"
}

resource "aws_vpc" "var.vpc_name" {
    cidr_block = var.vpc_cidr
    region    = var.region

    tags = {
        Terraform   = "true"
        Environment = "production"
    }
  }

 resource "aws_subnet" "Public_Subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets[0]

  tags = {
    Name = "Main"
  }
} 

