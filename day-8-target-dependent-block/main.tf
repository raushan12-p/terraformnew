resource "aws_instance" "dependent" {
    ami = "ami-066784287e358dad1"
    instance_type = "t2.micro"
    key_name = "rau-key"
}

resource "aws_s3_bucket" "dependent" {
    bucket = "s3nareshtad212ffrg12et"
    depends_on = [ aws_instance.dependent ]
}
