################################################################################
# REDIS-SG
################################################################################
module "redis_sg" {
  source = "./modules-sg"

  name        = "${var.name}-${random_string.x.result}"
  description = var.project

  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  ingress_with_cidr_blocks = [
    {
      description = "vpc-access"
      rule        = "redis-tcp"
      cidr_blocks = var.vpc_cidr_block
      # cidr_blocks = join(",", var.private_subnets_cidr_blocks)
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "vpc-access"
      rule        = "redis-tcp"
      cidr_blocks = var.vpc_cidr_block
      # cidr_blocks = join(",", var.database_subnets_cidr_blocks)
    },
  ]

  # tags = local.common_tags
  tags = merge(
    var.default_tags,
    tomap({ "Name" = "${var.project}-${random_string.x.result}" })
  )
}
