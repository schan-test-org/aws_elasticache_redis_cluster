##  aws_elasticache_redis_cluster

### ex > tfvars

```terraform-tfvars

###############################################################################
# REDIS-CLUSTER-EX
###############################################################################

name           = "redis-test"
node_type      = "cache.t3.small"
engine_version = "6.x"

#### Primary-MODE
# parameter_group_name = "default.redis6.x"

#### Cluster-MODE
parameter_group_name = "default.redis6.x.cluster.on"

vpc_id         = "vpc-0e8acf616f7d0dd34"
vpc_cidr_block = "10.30.0.0/16"

# 클러스터 모드 고려하여 홀수개의 서브넷 사용하여 분산처리 되도록 설정
availability_zones = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
subnets            = ["subnet-0bf5c8264d64f7604", "subnet-08a9da6638e959a9d", "subnet-0c53faa6985411e79"]

# shard 갯수 설정 ( for shard )
num_cache        = 2
multi_az_enabled = true

# replica from 0 to 5 ( BUT, when using Multi-AZ from 1 to 5 )
num_replica = 2
port        = 6379

automatic_failover_enabled = true
at_rest_encryption_enabled = true
transit_encryption_enabled = true

```

### ex > using module

```terraform
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
```



### Available variables:
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | (Optional) Whether to enable encryption at rest | `bool` | `true` | no |
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | (Optional) The password used to access a password protected server. Can be specified only if `transit_encryption_enabled = true` | `string` | `null` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_cloudwatch_logging_enabled"></a> [cloudwatch\_logging\_enabled](#input\_cloudwatch\_logging\_enabled) | (Optional) Whether to enable cloudwatch logging | `bool` | `false` | no |
| <a name="input_cloudwatch_logging_retention_in_days"></a> [cloudwatch\_logging\_retention\_in\_days](#input\_cloudwatch\_logging\_retention\_in\_days) | Retention period for the logs in CloudWatch. Default is 7d. | `number` | `7` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The redis engine version | `string` | `"3.2.6"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | How do you want to call your environment | `string` | n/a | yes |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the redis cluster | `string` | n/a | yes |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The instance size of the redis cluster | `string` | n/a | yes |
| <a name="input_notification_topic_arn"></a> [notification\_topic\_arn](#input\_notification\_topic\_arn) | (Optional) ARN of an SNS topic to send ElastiCache notifications | `string` | `null` | no |
| <a name="input_num_cache_nodes"></a> [num\_cache\_nodes](#input\_num\_cache\_nodes) | The number of cache nodes | `number` | n/a | yes |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The parameter group name | `string` | `"default.redis3.2"` | no |
| <a name="input_port"></a> [port](#input\_port) | The redis port | `number` | `6379` | no |
| <a name="input_project"></a> [project](#input\_project) | The project this redis cluster belongs to | `string` | n/a | yes |
| <a name="input_snapshot_arns"></a> [snapshot\_arns](#input\_snapshot\_arns) | (Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my\_bucket/snapshot1.rdb | `list(string)` | `[]` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot\_retention\_limit is not supported on cache.t1.micro or cache.t2.* cache nodes | `number` | `0` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum maintenance window is a 60 minute period. Example: 05:00-09:00 | `string` | `"03:00-05:00"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The subnets where the redis cluster is deployed | `list(string)` | n/a | yes |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | (Optional) Whether to enable encryption in transit | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The vpc where we will put the redis cluster | `string` | n/a | yes |
