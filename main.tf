resource "aws_ecs_cluster" "this" {
  name = "ecs-deployments-poc"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}