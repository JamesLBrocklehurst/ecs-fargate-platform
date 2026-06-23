# VPC

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}

# Subnets

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name        = each.key
    Terraform   = "true"
    Environment = "production"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name        = each.key
    Terraform   = "true"
    Environment = "production"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "main-igw"
    Terraform   = "true"
    Environment = "production"
  }
}

# EIP + NAT Gateway

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "nat-eip"
    Terraform   = "true"
    Environment = "production"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[keys(var.public_subnets)[0]].id

  tags = {
    Name        = "main-nat"
    Terraform   = "true"
    Environment = "production"
  }

  depends_on = [aws_internet_gateway.main]
}


# ROUTE TABLES


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "public-rt"
    Terraform   = "true"
    Environment = "production"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "private-rt"
    Terraform   = "true"
    Environment = "production"
  }
}

# -------------------------------------------------------
# ROUTE TABLE ASSOCIATIONS
# -------------------------------------------------------

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}