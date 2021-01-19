resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Project = var.project_name
    Name    = "Project ${var.project_name} VPC"
  }
}

resource "aws_subnet" "demo_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.0.0/24"

  tags = {
    Project = var.project_name
    Name    = "${var.project_name} subnet 0"
  }
}

resource "aws_internet_gateway" "main_gate" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet-gateway"
  }
}

resource "aws_route_table" "out_route" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gate.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.out_route.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "SSH from admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
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