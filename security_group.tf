resource "aws_security_group" "ec2_security" {
  name        = "ec2-security-group"
  description = "Allow HTTP and RDP traffic"
  vpc_id      = "vpc-060aacac2f11e811c"

  lifecycle {
    ignore_changes = [vpc_id]
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
  tags = {
    Name = "EC2SecurityGroup"
  }
}

resource "aws_security_group" "rds_security" {
  name        = "rds-security-group"
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.porto_vpc.id
  ingress {
    from_port   = 3306
    to_port     = 3306
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
    Name = "RDSSecurityGroup"
  }
}

resource "aws_security_group" "ecs_security" {
  name        = "ecs-security-group"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.porto_vpc.id
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
  tags = {
    Name = "ECSSecurityGroup"
  }
}

resource "aws_security_group" "lb_security" {
  vpc_id      = aws_vpc.porto_vpc.id
  name        = "lb-security-group"
  description = "Allow HTTP traffic for the Load Balancer"
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
  tags = {
    Name = "LoadBalancerSecurityGroup"
  }
}