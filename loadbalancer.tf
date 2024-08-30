resource "aws_lb" "api_lb" {
  name                       = "api-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lb_security.id]
  subnets                    = [aws_subnet.public_subnet_a.id, aws_subnet.private_subnet_b.id]
  enable_deletion_protection = false
  tags = {
    Name = "ApiLoadBalancer"
  }
}