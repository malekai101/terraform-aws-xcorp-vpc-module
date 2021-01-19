output "vpc_id" {
    description = "ID of the VPC"
    value = aws_vpc.main_vpc.id
}

output "vpc_name" {
    description = "Name of the VPC"
    value = aws_vpc.main_vpc.tags["Name"]
}

output "subnet_id" {
    description = "ID of the subnet"
    value = aws_subnet.demo_subnet.id
}

output "ssh_rule_id" {
    description = "ID of the allow SSH security group"
    value = aws_security_group.allow_ssh.id
}

