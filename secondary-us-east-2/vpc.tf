
#  creating vpc 

resource "aws_vpc" "three-tier" {
    provider = aws.secondary
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    tags = {
        Name = "3-tier-vpc"
    }
}

resource "aws_subnet" "pub1" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-2a"
    map_public_ip_on_launch = true  # for auto asign public ip for subnet
    tags = {
    Name = "pub-1a"
  }
}

resource "aws_subnet" "pub2" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-2b"
    map_public_ip_on_launch = true  # for auto asign public ip for subnet
    tags = {
    Name = "pub-2b"
  }
}

resource "aws_subnet" "prvt3" {
    provider = aws.secondary  
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-2a"
    tags = {
    Name = "prvt-3a"
  }
}

resource "aws_subnet" "prvt4" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-2b"
    tags = {
    Name = "prvt-4b"
  }
  
}

resource "aws_subnet" "prvt5" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "us-east-2a"
    tags = {
    Name = "prvt-5a"
  }
}

resource "aws_subnet" "prvt6" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.6.0/24"
    availability_zone = "us-east-2b"
    tags = {
    Name = "prvt-6b"
  }
}

resource "aws_subnet" "prvt7" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.7.0/24"
    availability_zone = "us-east-2a"
    tags = {
    Name = "prvt-7a"
  }
}

resource "aws_subnet" "prvt8" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.8.0/24"
    availability_zone = "us-east-2b"
    tags = {
    Name = "prvt-8b"
  }
}
#  creating internet gateway

resource "aws_internet_gateway" "three-tier-ig" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    tags = {
        Name = "3-tier-ig"
    }
}
#  creating public route table

resource "aws_route_table" "three-tier-pub-rt" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    tags = {
      Name = "3-tier-pub-rt"
    }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three-tier-ig.id
  }
}

#  attaching pub-1a subnet to public route table
resource "aws_route_table_association" "public-1a" {
    provider = aws.secondary
    route_table_id = aws_route_table.three-tier-pub-rt.id 
    subnet_id = aws_subnet.pub1.id
}

#  attaching pub-2b subnet to public route table
resource "aws_route_table_association" "public-2b" {
    provider = aws.secondary
    route_table_id = aws_route_table.three-tier-pub-rt.id 
    subnet_id = aws_subnet.pub2.id
}

#  creating elastic ip for nat gateway

resource "aws_eip" "eip" {
  provider = aws.secondary
  
  }

#  creating nat gateway
resource "aws_nat_gateway" "cust-nat" {
  provider = aws.secondary
  subnet_id = aws_subnet.pub1.id
  connectivity_type = "public"
  allocation_id = aws_eip.eip.id
  tags = {
    Name = "3-tier-nat"
  }
}

#  creating private route table 
resource "aws_route_table" "three-tier-prvt-rt" {
    provider = aws.secondary
    vpc_id = aws_vpc.three-tier.id
    tags = {
      Name = "3-tier-privt-rt"
    }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.cust-nat.id
  }
}

#  attaching prvt-3a subnet to private route table
resource "aws_route_table_association" "prvivate-3a" {
    provider = aws.secondary
    route_table_id = aws_route_table.three-tier-prvt-rt.id
    subnet_id = aws_subnet.prvt3.id
}

#  attaching prvt-4b subnet to private route table
resource "aws_route_table_association" "prvivate-4b" {
    provider = aws.secondary
    route_table_id = aws_route_table.three-tier-prvt-rt.id
    subnet_id = aws_subnet.prvt4.id
}

#  attaching prvt-5a subnet to private route table
resource "aws_route_table_association" "prvivate-5a" {
    provider = aws.secondary
    route_table_id = aws_route_table.three-tier-prvt-rt.id
    subnet_id = aws_subnet.prvt5.id
}

#  attaching prvt-6b subnet to private route table
resource "aws_route_table_association" "prvivate-6b" {
    provider = aws.secondary
    route_table_id = aws_route_table.three-tier-prvt-rt.id
    subnet_id = aws_subnet.prvt6.id
}

#  attaching prvt-7a subnet to private route table
resource "aws_route_table_association" "prvivate-7a" {
   provider = aws.secondary
    route_table_id = aws_route_table.three-tier-prvt-rt.id
    subnet_id = aws_subnet.prvt7.id
}

#  attaching prvt-8b subnet to private route table
resource "aws_route_table_association" "prvivate-8b" {
    provider = aws.secondary
    route_table_id = aws_route_table.three-tier-prvt-rt.id
    subnet_id = aws_subnet.prvt8.id
}