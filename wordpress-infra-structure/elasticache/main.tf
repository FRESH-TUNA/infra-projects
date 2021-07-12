resource "aws_elasticache_subnet_group" "app_db" {
  name       = "app_data_subnet_group"
  subnet_ids = var.data_subnet_ids
}

resource "aws_elasticache_cluster" "app_db" {
  cluster_id           = "app_db"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 2
  parameter_group_name = "default.memcached1.4"
  port                 = 11211
  subnet_group_name = aws_elasticache_subnet_group.app_db.name
  security_group_ids = var.sg_ids
}
