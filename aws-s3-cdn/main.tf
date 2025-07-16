## Data Block For availability Zone ##
data "aws_availability_zones" "available" {
    state = "available"
}
data "aws_iam_policy" "ssm_managed_instance_core" {
  name = "AmazonSSMManagedInstanceCore"
}


################################## Network ###################################

module "network" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.environment}-${var.stack_name}-vpc"
  cidr = var.vpc_cidr_range


  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

}

################################# S3 ####################################


module "s3_bucket" {
  source                  = "terraform-aws-modules/s3-bucket/aws"
  version                 = "3.6.0"
  bucket                  = "${var.environment}-${var.stack_name}-s3-cdn"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  force_destroy = true

  versioning = {
    enabled = true
  }
  tags = {
    purpose = "S3 Bucket for code hosting"
  }
}

# s3 bucket policy
resource "aws_s3_bucket_policy" "s3bucketpolicy" {
  bucket = module.s3_bucket.s3_bucket_id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": {
        "Sid": "AllowCloudFrontServicePrincipalReadOnly",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudfront.amazonaws.com"
        },
        "Action": "s3:GetObject",
        "Resource": "${module.s3_bucket.s3_bucket_arn}/*",
        "Condition": {
            "StringEquals": {
                "AWS:SourceArn": "${module.cloudfront.cloudfront_distribution_arn}"
            }
        }
    }
}
POLICY
}




######################################### CDN ##########################################


module "cloudfront" {
  source                       = "terraform-aws-modules/cloudfront/aws"
  version                      = "3.2.0"
  
  depends_on = [
    module.s3_bucket,      
  ]
  aliases                      = var.cdn_aliases
  comment                      = "${var.environment}-${var.stack_name}-cdn"
  enabled                      = true
  is_ipv6_enabled              = true
  price_class                  = "PriceClass_All"
  retain_on_delete             = false
  wait_for_deployment          = false
  create_origin_access_control = true
  
  
  origin_access_control = {
    "${var.environment}-${var.stack_name}-cdn" = {
      description      = "${var.environment}-${var.stack_name}-cloudfront-origin"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }
   origin = {
    "${var.environment}-${var.stack_name}-origin" = {
      domain_name           = "${module.s3_bucket.s3_bucket_bucket_regional_domain_name}"
      origin_access_control = "${var.environment}-${var.stack_name}-cdn" # key in `origin_access_control`
      origin_id             = "${var.environment}-${var.stack_name}-${module.s3_bucket.s3_bucket_bucket_regional_domain_name}"
    }
  }
  default_cache_behavior = {
    path_pattern           = "/*"
    target_origin_id       = "${var.environment}-${var.stack_name}-${module.s3_bucket.s3_bucket_bucket_regional_domain_name}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    use_forwarded_values   = false
  }
  viewer_certificate = {
    acm_certificate_arn = "${var.acm_certificate_arn}"
    ssl_support_method  = "sni-only"
  }
  
  default_root_object = "index.html"
  custom_error_response = [{
    error_code         = 404
    response_code      = 404
    response_page_path = "/index.html"
    },
    {
      error_code         = 403
      response_code      = 403
      response_page_path = "/index.html"
  }]
  tags = {
    purpose = "CF distribution for ${var.environment}-${var.stack_name}-stack"
  }
}



######################################### Route 53 #######################################

resource "aws_route53_record" "record" {
  count = length(var.cdn_aliases)

  zone_id = var.hosted_zone_id
  name    = var.cdn_aliases[count.index]
  type    = "CNAME"
  ttl     = 600 

  records = [module.cloudfront.cloudfront_distribution_domain_name]
}








