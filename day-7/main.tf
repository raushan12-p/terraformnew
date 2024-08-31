resource "aws_lb_target_group" "front_end" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0724a77e8c6c53d48"
}