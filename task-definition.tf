data "template_file" "definition" {
  template = file("./task-definition.json.tpl")
}

resource "aws_ecs_task_definition" "service" {
  family                   = "generator"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 256
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.definition.rendered
}