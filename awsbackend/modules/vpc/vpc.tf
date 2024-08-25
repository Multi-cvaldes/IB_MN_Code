resource "aws_vpc" "MultinucleoVPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name    = "MultinucleoVPC"
    Project = "Multinucleo TF Code"
  }
}

resource "aws_internet_gateway" "MultinucleoIGW" {
  vpc_id = aws_vpc.MultinucleoVPC.id
  tags = {
    Name    = "MultinucleoIGW"
    Project = "Multinucleo TF Code"
  }
}

resource "aws_eip" "MultinucleoNatGatewayEIP1" {
  tags = {
    Name    = "MultinucleoNatGatewayEIP1"
    Project = "Multinucleo TF Code"
  }
}
resource "aws_nat_gateway" "MultinucleoNatGateway1" {
  allocation_id = aws_eip.MultinucleoNatGatewayEIP1.id
  subnet_id     = aws_subnet.MultinucleoPublicSubnet1.id
  tags = {
    Name    = "MultinucleoNatGateway1"
    Project = "Multinucleo TF Code"
  }
}
resource "aws_subnet" "MultinucleoPublicSubnet1" {
  vpc_id            = aws_vpc.MultinucleoVPC.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "MultinucleoPublicSubnet1"
    Project = "Multinucleo TF Code"
  }
}

resource "aws_eip" "MultinucleoNatGatewayEIP2" {
  tags = {
    Name    = "MultinucleoNatGatewayEIP2"
    Project = "Multinucleo TF Code"
  }
}
resource "aws_nat_gateway" "MultinucleoNatGateway2" {
  allocation_id = aws_eip.MultinucleoNatGatewayEIP2.id
  subnet_id     = aws_subnet.MultinucleoPublicSubnet1.id
  tags = {
    Name    = "MultinucleoNatGateway2"
    Project = "Multinucleo TF Code"
  }
}
resource "aws_subnet" "MultinucleoPublicSubnet2" {
  vpc_id            = aws_vpc.MultinucleoVPC.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "MultinucleoPublicSubnet2"
    Project = "Multinucleo TF Code"
  }
}

resource "aws_subnet" "MultinucleoPrivateSubnet1" {
  vpc_id            = aws_vpc.MultinucleoVPC.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "MultinucleoPrivateSubnet1"
    Project = "Multinucleo TF Code"
  }
}
resource "aws_subnet" "MultinucleoPrivateSubnet2" {
  vpc_id            = aws_vpc.MultinucleoVPC.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "MultinucleoPrivateSubnet2"
    Project = "Multinucleo TF Code"
  }
}

resource "aws_route_table" "MultinucleoPublicRT" {
  vpc_id = aws_vpc.MultinucleoVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MultinucleoIGW.id
  }
  tags = {
    Name    = "MultinucleoPublicRT"
    Project = "Multinucleo TF Code"
  }
}
resource "aws_route_table" "MultinucleoPrivateRT1" {
  vpc_id = aws_vpc.MultinucleoVPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.MultinucleoNatGateway1.id
  }
  tags = {
    Name    = "MultinucleoPrivateRT1"
    Project = "Multinucleo TF Code"
  }
}
resource "aws_route_table" "MultinucleoPrivateRT2" {
  vpc_id = aws_vpc.MultinucleoVPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.MultinucleoNatGateway2.id
  }
  tags = {
    Name    = "MultinucleoPrivateRT2"
    Project = "Multinucleo TF Code"
  }
}

resource "aws_route_table_association" "MultinucleoPublicRTassociation1" {
  subnet_id      = aws_subnet.MultinucleoPublicSubnet1.id
  route_table_id = aws_route_table.MultinucleoPublicRT.id
}
resource "aws_route_table_association" "MultinucleoPublicRTassociation2" {
  subnet_id      = aws_subnet.MultinucleoPublicSubnet2.id
  route_table_id = aws_route_table.MultinucleoPublicRT.id
}
resource "aws_route_table_association" "MultinucleoPrivateRTassociation1" {
  subnet_id      = aws_subnet.MultinucleoPrivateSubnet1.id
  route_table_id = aws_route_table.MultinucleoPrivateRT1.id
}
resource "aws_route_table_association" "MultinucleoPrivateRTassociation2" {
  subnet_id      = aws_subnet.MultinucleoPrivateSubnet2.id
  route_table_id = aws_route_table.MultinucleoPrivateRT2.id
}
