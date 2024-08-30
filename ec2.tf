resource "aws_instance" "web_server" {
  ami           = "ami-07d9456e59793a7d5"
  instance_type = "t2.micro"
  tags = {
    Name = "ShopPortoWebServer"
  }
  vpc_security_group_ids = [aws_security_group.ecs_security.id]
  subnet_id = aws_subnet.public_subnet_a.id
}