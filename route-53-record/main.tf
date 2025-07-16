resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = var.record_type
  records = var.enable_alias == false ? var.value : null
  ttl     = var.enable_alias == false ? var.ttl : null

  set_identifier = var.routing_policy == "Weighted" || var.routing_policy == "GeoLocation" || var.routing_policy == "IPBased" ? var.set_identifier : null

  dynamic "alias" {
    for_each = var.enable_alias ? [true] : []
    content {
      name                   = var.alias_name
      zone_id                = var.target_hosted_zone_id
      evaluate_target_health = var.enable_target_health
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = var.routing_policy == "Weighted" ? [true] : []
    content {
      weight = var.weight
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = var.routing_policy == "GeoLocation" ? [true] : []
    content {
      continent   = var.continent
    }
  }

  dynamic "cidr_routing_policy" {
    for_each = var.routing_policy == "IPBased" ? [true] : []
    content {
      location_name = var.location_name  
      collection_id = var.collection_id   
    }
  }
}
