
locals {
  region = var.aws_region
  # vpc_id = var.vpc_id

  common_tags = merge(var.default_tags, {
    "region"  = var.aws_region
    "project" = var.project
    "env"     = var.env
    "managed" = "terraform"
  })


}

#############################
resource "random_string" "x" {
  length  = 3
  special = false
  upper   = false
}

# random_string.x.result
#############################

module "redis" {
  source      = "./_redis-md"
  name        = var.name
  project     = var.project
  environment = var.env

  engine_version = var.engine_version
  port           = var.port

  parameter_group_name   = var.parameter_group_name
  vpc_security_group_ids = [module.redis_sg.security_group_id]

  vpc_id             = var.vpc_id
  subnets            = var.subnets
  availability_zones = var.availability_zones
  multi_az_enabled   = var.multi_az_enabled

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled

  node_type       = var.node_type
  num_cache_nodes = var.num_cache
  num_replica     = var.num_replica

  automatic_failover_enabled = var.automatic_failover_enabled
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  snapshot_arns              = var.snapshot_arns

  auth_token             = var.auth_token
  notification_topic_arn = var.notification_topic_arn
}
