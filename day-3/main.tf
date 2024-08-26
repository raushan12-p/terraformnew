resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name="dev"
  }
}
resource "aws_internet_gateway" "cust" {
  vpc_id = aws_vpc.cust.id
  tags = {
    name="cust_ig"

  }
}
resource "aws_subnet" "cust" {
    vpc_id = aws_vpc.cust.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      name="cust_subnet"
    }
}
resource "aws_subnet" "cust2" {
    vpc_id = aws_vpc.cust.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
      name="cust_subnet"
    }
}
resource "aws_route_table" "cust" {
  vpc_id = aws_subnet.cust.id
  route = {
    gateway_id= aws_internet_gateway.cust.id
    cidr_block="0.0.0.0/0"
  }
}

resource "aws_route_table_association" "cust" {
    subnet_id = aws_subnet.cust.id
    route_table_id = aws_route_table.cust.id

}
resource "aws_security_group" "allotw_tls" {
    name = "allow_list"
    vpc_id = aws_vpc.dev
    tags = {
      name="dev_sg"
    }
 ingress = {
    description="TLS from vpc"
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
 }
ingress{
    description = "TLS from vpc"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

}
egress = {
    from_port=0
    to_port=0
    protocol="1"
    cidr_blocks=["0.0.0.0/0"]

}

}
resource "aws_instance" "prod" {
  ami = "ami-066784287e358dad1"
  instance_type = "t2.micro"
  key_name = "aws_key"
  subnet_id = aws_subnet.cust.id
  vpc_security_group_ids =[ aws_security_group.allow_list.id]
}