# VPC
resource "aws_vpc" "vpc_demo" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  enable_classiclink = var.enable_classiclink


  tags = {
    Name = var.tags
  }
}

#Public subnets
resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.vpc_demo.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_1-demo"
  }
}
resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.vpc_demo.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public_2-demo"
  }
}
resource "aws_subnet" "public_3" {
  vpc_id     = aws_vpc.vpc_demo.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "public_3-demo"
  }
}

#Private subnets
resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.vpc_demo.id
  map_public_ip_on_launch = false
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private_1-demo"
  }
}
resource "aws_subnet" "private_2" {
  vpc_id     = aws_vpc.vpc_demo.id
  map_public_ip_on_launch = false
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "private_2-demo"
  }
}
resource "aws_subnet" "private_3" {
  vpc_id     = aws_vpc.vpc_demo.id
  map_public_ip_on_launch = false
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "private_3-demo"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "igw_demo" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "internet-gateway-demo"
  }
}
# Route Table for public subnets
resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.vpc_demo.id

   route {
     cidr_block = "10.0.0.0/0"
     gateway_id = aws_internet_gateway.igw_demo.id
   }

   tags = {
     Name = "public-route-table-demo"
   }
 }
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.route-public.id
}
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.route-public.id
}
resource "aws_route_table_association" "public_3" {
  subnet_id      = aws_subnet.public_3.id
  route_table_id = aws_route_table.route-public.id
}

# nat gateway && Route table for private subnet
resource "aws_eip" "nat" {
  vpc = true
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id
  depends_on    = ["aws_internet_gateway.igw_demo"]

  tags = {
    Name = "nat-gw-demo"
  }
}
resource "aws_route_table" "route-private" {
  vpc_id = aws_vpc.vpc_demo.id

   route {
     cidr_block = "10.0.0.0/0"
     gateway_id = aws_nat_gateway.nat_gw.id
   }

   tags = {
     Name = "private-route-table-demo"
   }
 }
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.route-private.id
}
resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.route-private.id
}
resource "aws_route_table_association" "private_3" {
  subnet_id      = aws_subnet.private_3.id
  route_table_id = aws_route_table.route-private.id
}

# Security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_SSH"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_demo.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
