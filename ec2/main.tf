resource "aws_key_pair" "key" {
  key_name   = "my_key"
  public_key = file("my_key.pub")
}

resource "aws_vpc" "ex_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My_vpc"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.ex_vpc.id
  tags = {
    Name = "My-IG"
  }
}

resource "aws_eip" "ng_eip" {
  domain = "vpc"
  tags = {
    Name = "ng_eip"
  }
}

resource "aws_nat_gateway" "ng" {
  allocation_id = aws_eip.ng_eip.id
  subnet_id     = aws_subnet.ex_sub2.id
  tags = {
    Name = "Nat_Gateway"
  }
}

resource "aws_route_table" "my-public-rt" {
  vpc_id = aws_vpc.ex_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "my-private-rt" {
  vpc_id = aws_vpc.ex_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ng.id
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.ex_sub1.id
  route_table_id = aws_route_table.my-public-rt.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.ex_sub2.id
  route_table_id = aws_route_table.my-private-rt.id
}

resource "aws_subnet" "ex_sub1" {
  vpc_id                  = aws_vpc.ex_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}
resource "aws_subnet" "ex_sub2" {
  vpc_id     = aws_vpc.ex_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_security_group" "ex_sg" {
  description = "Allow Http and SSH."
  tags = {
    Name = "My_sg"
  }
  vpc_id = aws_vpc.ex_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "ex_in" {
  key_name               = aws_key_pair.key.key_name
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.ex_sub1.id
  vpc_security_group_ids = [aws_security_group.ex_sg.id]
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
  tags = {
    Name = "Prem_terra-ec2"
  }
}