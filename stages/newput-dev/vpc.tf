/*
locals {
  subnet_max = 2
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>3.19.0"

  name = var.vpc_name
  cidr = var.cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  // Take all even /16 blocks for each AZ and split it up into two /18's for the public and spare subnets
  public_subnets = [for id in range(var.az_count) : cidrsubnet(var.cidr, 4, local.subnet_max * id)]
  // Use all odd /16 blocks for private subnets
  private_subnets = [for id in range(var.az_count) : cidrsubnet(var.cidr, 4, 2 * id + 1)]

  private_subnet_tags = var.private_subnet_tags
  public_subnet_tags  = var.public_subnet_tags

  enable_nat_gateway     = true
  single_nat_gateway     = !var.production
  one_nat_gateway_per_az = var.production

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  vpc_tags = var.vpc_tags

  tags = local.tags
}
*/
# Fetch AZs in the current region

# need to check
resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = merge(local.tags, {
    Name = var.vpc_name
  })
}

# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "np-${var.stage}-private-subnet"
  })
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "np-${var.stage}-public-subnet"
  })
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "np-${var.stage}-internet-gateway"
  })
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "gw" {
  # count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.gw]

  tags = merge(local.tags, {
    Name = "np-${var.stage}-elastic-ip"
  })
}

resource "aws_nat_gateway" "gw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.gw.*.id, 0) # element(aws_eip.gw.*.id, count.index)

  tags = merge(local.tags, {
    Name = "np-${var.stage}-nat-gateway"
  })
}

# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  # count  = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id # element(aws_nat_gateway.gw.*.id, count.index)
  }

  tags = merge(local.tags, {
    Name = "np-${var.stage}-private-rt"
  })
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id # element(aws_route_table.private.*.id, count.index)
}
