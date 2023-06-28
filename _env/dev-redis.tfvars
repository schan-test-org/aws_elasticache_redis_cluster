###############################################################################
# Common Variables
###############################################################################
project    = "testmz-redis"
aws_region = "ap-northeast-2"

default_tags = {
  dept  = "Platform Service Architect Group / DevOps SWAT Team"
  email = "schan@mz.co.kr"
}

env = "dev"

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

###############################################################################
#
###############################################################################



