resource "aws_vpc" "vpc-test" {
    cidr_block = var.vpcip
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags =merge(
      local.common_tags,
      {
        Name = "${local.resource_prefix}vpc-test"
      }
    )
}

resource "aws_subnet" "subnet-AZ-a-test-public" {
  vpc_id = "${aws_vpc.vpc-test.id}"
  cidr_block = var.subnet-azs-ips.az-a-public
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1a"
  tags =merge(
      local.common_tags,
      {
        Name = "${local.resource_prefix}subnet-AZ-a-public-test"
      }
    )
} 


resource "aws_subnet" "subnet-AZ-b-test-public" {
  vpc_id = "${aws_vpc.vpc-test.id}"
  cidr_block = var.subnet-azs-ips.az-b-public
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1b"
  tags =merge(
      local.common_tags,
      {
        Name = "${local.resource_prefix}subnet-AZ-b-public-test"
      }
    )
} 



resource "aws_subnet" "subnet-AZ-a-test-private" {
  vpc_id = "${aws_vpc.vpc-test.id}"
  cidr_block = var.subnet-azs-ips.az-a-private
  map_public_ip_on_launch = false
  availability_zone = "eu-central-1a"
  tags =merge(
      local.common_tags,
      {
        Name = "${local.resource_prefix}subnet-AZ-a-private-test"
      }
    )
} 


resource "aws_subnet" "subnet-AZ-b-test-private" {
  vpc_id = "${aws_vpc.vpc-test.id}"
  cidr_block = var.subnet-azs-ips.az-b-private
  map_public_ip_on_launch = false
  availability_zone = "eu-central-1b"
  tags =merge(
      local.common_tags,
      {
        Name = "${local.resource_prefix}subnet-AZ-b-private-test"
      }
    )
} 



resource "aws_internet_gateway" "test-vpc-internet-gateway" {
  vpc_id = "${aws_vpc.vpc-test.id}"
  tags =merge(
      local.common_tags,
      {
        Name = "${local.resource_prefix}internet-gateway-test"
      }
    )
}

resource "aws_route_table" "private-route-table" {
  vpc_id = "${aws_vpc.vpc-test.id}"
  tags =merge(
    local.common_tags,
    {
      Name = "${local.resource_prefix}private-route-table-test"
    }
  )
}

resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.vpc-test.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-vpc-internet-gateway.id
  }
  tags =merge(
    local.common_tags,
    {
      Name = "${local.resource_prefix}public-route-table-test"
    }
  )
}

resource "aws_route_table_association" "private-az-a-route-association" {
  subnet_id = "${aws_subnet.subnet-AZ-a-test-private.id}"
  route_table_id = aws_route_table.private-route-table.id
  
}
resource "aws_route_table_association" "private-az-b-route-association" {
  subnet_id = "${aws_subnet.subnet-AZ-b-test-private.id}"
  route_table_id = aws_route_table.private-route-table.id
  
}

resource "aws_route_table_association" "public-az-a-route-association" {
  subnet_id = "${aws_subnet.subnet-AZ-a-test-public.id}"
  route_table_id = aws_route_table.public-route-table.id
  
}
resource "aws_route_table_association" "public-az-b-route-association" {
  subnet_id = "${aws_subnet.subnet-AZ-b-test-public.id}"
  route_table_id = aws_route_table.public-route-table.id
  
}

output "vpc-outputs" {
  value = {
    vpc_id = {
      ARN = aws_vpc.vpc-test.arn
      Name = aws_vpc.vpc-test.tags.Name
    }
    subnet-AZ-a-test-public = {
      ARN = aws_subnet.subnet-AZ-a-test-public.arn
      Name = aws_subnet.subnet-AZ-a-test-public.tags.Name
    }
    subnet-AZ-b-test-public = {
      ARN = aws_subnet.subnet-AZ-b-test-public.arn
      Name = aws_subnet.subnet-AZ-b-test-public.tags.Name
    }
    subnet-AZ-a-test-private = {
      ARN = aws_subnet.subnet-AZ-a-test-private.arn
      Name = aws_subnet.subnet-AZ-a-test-private.tags.Name
    }
    subnet-AZ-b-test-private = {
      ARN = aws_subnet.subnet-AZ-b-test-private.arn
      Name = aws_subnet.subnet-AZ-b-test-private.tags.Name
    }
    test-vpc-internet-gateway = {
      ARN = aws_internet_gateway.test-vpc-internet-gateway.arn
      Name = aws_internet_gateway.test-vpc-internet-gateway.tags.Name
    }
    private-route-table = {
      ARN = aws_route_table.private-route-table
      //Name = aws_route_table.private-route-table.tags.Name
    }
    public-route-table = {
      ARN = aws_route_table.public-route-table
      //Name = aws_route_table.public-route-table.tags.Name
     }
  } 
}
