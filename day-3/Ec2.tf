  resource "aws_instance" "prod" {
    ami = "ami-066784287e358dad1"
    instance_type = "t2.nano"
    key_name = "rau-key"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    tags = {
      Name = "myec2"
    }
  }