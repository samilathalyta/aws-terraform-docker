resource "aws_vpc" "porto_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "porto-vpc"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.porto_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.porto_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet-b"
  }
}

resource "aws_internet_gateway" "internet_gat" {
  vpc_id = aws_vpc.porto_vpc.id
  tags = {
    Name = "internet-gat-one"
  }
}

resource "aws_route_table" "net-gatway" {
  vpc_id = aws_vpc.porto_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gat.id
  }

  tags = {
    name = "internet-gat-route-tab"
  }
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.net-gatway.id
}