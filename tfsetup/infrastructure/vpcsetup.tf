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

output "vpc_id" {
  value = {
    ARN = aws_vpc.vpc-test.arn
    Name = aws_vpc.vpc-test.tags.Name
  }
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

output "subnet-AZ-a-test-public" {
  value = {
    ARN = aws_subnet.subnet-AZ-a-test-public.arn
    Name = aws_subnet.subnet-AZ-a-test-public.tags.Name
  }
  
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

output "subnet-AZ-b-test-public" {
  value = {
    ARN = aws_subnet.subnet-AZ-b-test-public.arn
    Name = aws_subnet.subnet-AZ-b-test-public.tags.Name
  }  
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

output "subnet-AZ-a-test-private" {
  value = {
    ARN = aws_subnet.subnet-AZ-a-test-private.arn
    Name = aws_subnet.subnet-AZ-a-test-private.tags.Name
  }
  
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

output "subnet-AZ-b-test-private" {
  value = {
    ARN = aws_subnet.subnet-AZ-b-test-private.arn
    Name = aws_subnet.subnet-AZ-b-test-private.tags.Name
  }  
}

