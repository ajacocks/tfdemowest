

resource "aws_vpc" "tfvpc" {
  name       = "${var.vpc_name}-${var.user_name}-vpc"
  cidr_block = var.cidr_block
}

resource "aws_security_group" "tfsg" {
  name        = "${var.vpc_name}-${var.user_name}-sg"
  description = "Security group with rule descriptions created by Terraform via Ansible"
  vpc_id      = aws_vpc.tfvpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.100.100.0/24"]
  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = 1
  vpc_id                  = aws_vpc.tfvpc.id
  cidr_block              = ["${var.vpc_cidr}"]
  name                    = "${var.vpc_name}-${var.user_name}-public-subnet"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.tfvpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.tfvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

resource "aws_route_table_association" "rtassc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}