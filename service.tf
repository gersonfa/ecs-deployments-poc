resource "aws_ecs_service" "this" {
  name            = "staging"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnet_ids.default.ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "generator"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.this, aws_iam_role_policy_attachment.ecs_task_execution_role]
}