

# VPC resource
resource "aws_vpc" "devops_vpc" {
  cidr_block       = "10.0.0.0/16"  # Desired CIDR block
  instance_tenancy = "default"

  tags = {
    Name = "devops-assignment-4"
  }
}

# Public subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.0.0.0/24"  
  availability_zone = "us-east-1a"

  tags = {
    Name = "cs423-devops-public-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "cs423-devops-public-2"
  }
}

# Private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "cs423-devops-private-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "cs423-devops-private-2"
  }
}

# Internet gateway
resource "aws_internet_gateway" "devops_vpc_gw" {
  vpc_id = aws_vpc.devops_vpc.id
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_vpc.devops_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"  # Route all traffic to the IGW
  gateway_id             = aws_internet_gateway.devops_vpc_gw.id
} //associates igw with public sunnets 

# Private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops-assignment-4-private-route"
  }
}

# Associate public subnets with the main route table
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_vpc.devops_vpc.main_route_table_id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_vpc.devops_vpc.main_route_table_id
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}