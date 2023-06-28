locals {
  log_delivery_configuration = var.cloudwatch_logging_enabled ? ["slow-log", "engine-log"] : []
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.environment}-${var.name}"
  replication_group_description = "Redis cluster for ${var.environment}-${var.name}"

  node_type                  = var.node_type
  automatic_failover_enabled = var.automatic_failover_enabled
  auto_minor_version_upgrade = false

  multi_az_enabled           = var.multi_az_enabled
  engine                     = "redis"
  engine_version             = var.engine_version
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  kms_key_id                 = var.kms_key_id
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token

  port                 = var.port
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = aws_elasticache_subnet_group.elasticache.id
  security_group_ids   = var.vpc_security_group_ids

  snapshot_arns          = var.snapshot_arns
  snapshot_name          = var.snapshot_name
  apply_immediately      = var.apply_immediately
  maintenance_window     = var.redis_maintenance_window
  notification_topic_arn = var.notification_topic_arn

  snapshot_window          = var.snapshot_window
  snapshot_retention_limit = var.snapshot_retention_limit

  #### Primary-MODE
  # number_cache_clusters   = var.num_cache_nodes

  #### Cluster-MODE
  num_node_groups         = var.num_cache_nodes
  replicas_per_node_group = var.num_replica

  dynamic "log_delivery_configuration" {
    for_each = local.log_delivery_configuration

    content {
      destination      = aws_cloudwatch_log_group.redis[0].name
      destination_type = "cloudwatch-logs"
      log_format       = "text"
      log_type         = log_delivery_configuration.value
    }
  }

  tags = {
    Name        = "${var.environment}-${var.name}"
    Environment = var.environment
    Project     = var.name
  }
}

resource "aws_elasticache_subnet_group" "elasticache" {
  name        = "${var.project}-${var.environment}-redis"
  description = "Our main group of subnets"
  subnet_ids  = var.subnets
}

resource "aws_cloudwatch_log_group" "redis" {
  count = var.cloudwatch_logging_enabled ? 1 : 0

  name              = "redis"
  retention_in_days = var.cloudwatch_logging_retention_in_days
}
