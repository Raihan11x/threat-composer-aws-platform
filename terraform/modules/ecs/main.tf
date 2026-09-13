data "aws_region" "current" {}

resource "aws_cloudwatch_log_group" "application" {
  name              = "/ecs/${var.name_prefix}"
  retention_in_days = var.log_retention_days

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-logs"
  })
}

resource "aws_ecs_cluster" "application" {
  name = "${var.name_prefix}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-cluster"
  })
}

resource "aws_security_group" "tasks" {
  name_prefix = "${var.name_prefix}-tasks-"
  description = "Controls traffic to the ECS application tasks"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-tasks"
  })
}

resource "aws_vpc_security_group_ingress_rule" "application" {
  security_group_id            = aws_security_group.tasks.id
  referenced_security_group_id = var.load_balancer_security_group_id
  description                  = "Allow application traffic from the load balancer"

  from_port   = var.container_port
  to_port     = var.container_port
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.tasks.id
  description       = "Allow tasks to reach AWS services and the internet"

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_ecs_task_definition" "application" {
  family                   = var.name_prefix
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.task_cpu)
  memory                   = tostring(var.task_memory)
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.cpu_architecture
  }

  container_definitions = jsonencode([
    {
      name      = "application"
      image     = var.image_uri
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.application.name
          awslogs-region        = data.aws_region.current.region
          awslogs-stream-prefix = "application"
        }
      }
    }
  ])

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-task"
  })
}

resource "aws_ecs_service" "application" {
  name                    = "${var.name_prefix}-service"
  cluster                 = aws_ecs_cluster.application.id
  task_definition         = aws_ecs_task_definition.application.arn
  desired_count           = var.desired_count
  launch_type             = "FARGATE"
  platform_version        = "LATEST"
  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"
  wait_for_steady_state   = true

  health_check_grace_period_seconds = 60

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.tasks.id]
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "application"
    container_port   = var.container_port
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-service"
  })

}
