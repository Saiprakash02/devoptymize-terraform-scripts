## Data Block For availability Zone ##
data "aws_availability_zones" "available" {
    state = "available"
}


module "hub-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.stack_name}-hub-vpc"
  cidr = var.hub_vpc_cidr


  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = var.hub_private_cidrs
  public_subnets  = var.hub_public_cidrs
  create_database_subnet_group = false
  create_database_subnet_route_table= true
  database_subnets     = var.hub_tgw_cidrs

  enable_dns_hostnames = true
  enable_nat_gateway = true
  single_nat_gateway = false
  

}

# Create a route in the route table for hub route private1 CIDR block
resource "aws_route" "hub_route_private1" {
  route_table_id         = module.hub-vpc.private_route_table_ids[0]
  destination_cidr_block = var.spoke_vpc_a_cidr # Replace with the CIDR block for spoke 1
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  timeouts {
    create = "5m"
  }
  # depends_on = [
  #   aws_ec2_transit_gateway_route_table_association.association_hub_vpc,
  #   # Add other dependencies as needed
  # ]
}

resource "aws_route" "hub_route_private1a" {
  route_table_id         = module.hub-vpc.private_route_table_ids[0]
  destination_cidr_block = var.spoke_vpc_b_cidr # Replace with the CIDR block for spoke 1
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  timeouts {
    create = "5m"
  }
}

# Create a route in the route table for hub route private2 CIDR block
resource "aws_route" "hub_route_private2" {
  route_table_id         = module.hub-vpc.private_route_table_ids[1]
  destination_cidr_block = var.spoke_vpc_a_cidr # Replace with the CIDR block for spoke 1
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  timeouts {
    create = "5m"
  }
}

resource "aws_route" "hub_route_private2a" {
  route_table_id         = module.hub-vpc.private_route_table_ids[1]
  destination_cidr_block = var.spoke_vpc_b_cidr # Replace with the CIDR block for spoke 1
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  timeouts {
    create = "5m"
  }
}

################################# SPOKE VPC A ####################################

module "spoke-vpc-A" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.stack_name}-spoke-vpc-A"
  cidr = var.spoke_vpc_a_cidr


  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = var.spoke_private_a_cidrs
  public_subnets  = var.spoke_public_a_cidrs
  create_database_subnet_group = false
  create_database_subnet_route_table= true
  database_subnets     = var.spoke_tgw_a_cidrs

  enable_dns_hostnames = true
  enable_nat_gateway = false
  single_nat_gateway = false
  

}

# Create a route in the route table for spoke A route private CIDR block
resource "aws_route" "spoke1_route_private1" {
  route_table_id         = module.spoke-vpc-A.private_route_table_ids[0]
  destination_cidr_block = var.hub_vpc_cidr # Replace with the CIDR block for spoke 1
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  timeouts {
    create = "5m"
  }
}

resource "aws_route" "spoke1_route_private2" {
  route_table_id         = module.spoke-vpc-A.private_route_table_ids[1]
  destination_cidr_block = var.hub_vpc_cidr # Replace with the CIDR block for spoke 1
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  timeouts {
    create = "5m"
  }
}

####################################### SPOKE VPC B #######################################
module "spoke-vpc-B" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.stack_name}-spoke-vpc-B"
  cidr = var.spoke_vpc_b_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = var.spoke_private_b_cidrs
  public_subnets  = var.spoke_public_b_cidrs
  create_database_subnet_group = false
  create_database_subnet_route_table= true
  database_subnets     = var.spoke_tgw_b_cidrs

  enable_dns_hostnames = true
  enable_nat_gateway = false
  single_nat_gateway = false
  

}


# Create a route in the route table for spoke B route private CIDR block
resource "aws_route" "spoke2_route_private1" {
  route_table_id         = module.spoke-vpc-B.private_route_table_ids[0]
  destination_cidr_block = var.hub_vpc_cidr # Replace with the CIDR block for spoke 1
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  timeouts {
    create = "5m"
  }
}

resource "aws_route" "spoke2_route_private2" {
  route_table_id         = module.spoke-vpc-A.private_route_table_ids[1]
  destination_cidr_block = var.hub_vpc_cidr # Replace with the CIDR block for spoke 1
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  timeouts {
    create = "5m"
  }
}

########################### Create TGW ###################################
resource "aws_ec2_transit_gateway" "tgw" {
  description = "transit gateway"
  auto_accept_shared_attachments   = "enable"
  default_route_table_association   = "disable"
  default_route_table_propagation   = "disable"
  tags = {
    Name = "${var.stack_name}-tgw"
  }
}

###################  HUB VPC Transit Gateway Configuration ####################

resource "aws_ec2_transit_gateway_vpc_attachment" "hub_vpc_att" {
  subnet_ids                   = [module.hub-vpc.private_subnets[0], module.hub-vpc.private_subnets[1]]
  transit_gateway_id           = aws_ec2_transit_gateway.tgw.id
  vpc_id                       = module.hub-vpc.vpc_id

  tags = {
    Name = "${var.stack_name}-hub-tgw-attachment"
  }
}


resource "aws_ec2_transit_gateway_route_table" "hub_vpc_rt" {
  depends_on =[aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags = {
    Name = "${var.stack_name}-hub-vpc-transit-route-table"
  }
}

# # TGW Route Table for service vpc
resource "aws_ec2_transit_gateway_route" "tgw_hub_vpc_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hub_vpc_rt.id

}

resource "aws_ec2_transit_gateway_route_table_association" "association_hub_vpc" {
  depends_on =[aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att]
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hub_vpc_rt.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "propagation1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hub_vpc_rt.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "propagation2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hub_vpc_rt.id
}

###################  Spoke1 VPC Transit Gateway Configuration ####################

# Attach  TGW to Spoke 1
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_spoke1" {
  subnet_ids         = [module.spoke-vpc-A.private_subnets[0], module.spoke-vpc-A.private_subnets[1]]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.spoke-vpc-A.vpc_id
    tags = {
    Name = "${var.stack_name}-spoke1-tgw-attachment"
  }
}

resource "aws_ec2_transit_gateway_route_table" "spoke1_vpc_rt" {
  depends_on =[aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke1]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags = {
    Name = "${var.stack_name}-spoke1-transit-route-table"
  }
}

# TGW Route Table for spoke1 vpc
resource "aws_ec2_transit_gateway_route" "tgw_spoke1_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke1_vpc_rt.id

}

resource "aws_ec2_transit_gateway_route_table_association" "association_spoke1_vpc" {
  depends_on =[aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke1]
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke1_vpc_rt.id
}


resource "aws_ec2_transit_gateway_route_table_propagation" "propagation_spoke1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke1_vpc_rt.id
}


###################  Spoke2 VPC Transit Gateway Configuration ####################

# Attach  TGW to Spoke 2
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_spoke2" {
  subnet_ids         = [module.spoke-vpc-B.private_subnets[0], module.spoke-vpc-B.private_subnets[1]]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.spoke-vpc-B.vpc_id
    tags = {
    Name = "${var.stack_name}-spoke2-tgw-attachment"
  }
}

resource "aws_ec2_transit_gateway_route_table" "spoke2_vpc_rt" {
  depends_on =[aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke2]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags = {
    Name = "${var.stack_name}-spoke2-transit-route-table"
  }
}

# TGW Route Table for Spoke2 vpc
resource "aws_ec2_transit_gateway_route" "tgw_spoke2_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke2_vpc_rt.id

}

resource "aws_ec2_transit_gateway_route_table_association" "association_spoke2_vpc" {
  depends_on =[aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke2]
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_spoke2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke2_vpc_rt.id
}


resource "aws_ec2_transit_gateway_route_table_propagation" "propagation_spoke2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.hub_vpc_att.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke2_vpc_rt.id
}
