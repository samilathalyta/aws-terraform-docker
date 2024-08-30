resource "aws_ecs_cluster" "porto_cluster" {
  name = "porto-cluster"
}

resource "aws_ecs_task_definition" "api_task" {
  family                   = "api-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::959461793636:role/ECSFargateTaskExecutionRole" # ARN da role criada
  container_definitions = jsonencode([{
    name      = "api-container"
    image     = "959461793636.dkr.ecr.us-east-1.amazonaws.com/my-api-hello:latest" #imagem do docker/id
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

resource "aws_ecs_service" "api_service" {
  name            = "api-service"
  cluster         = aws_ecs_cluster.porto_cluster.id
  task_definition = aws_ecs_task_definition.api_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = [aws_subnet.public_subnet_a.id, aws_subnet.private_subnet_b.id]
    security_groups = [aws_security_group.ecs_security.id]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.api_tg.arn
    container_name   = "api-container"
    container_port   = 80
  }
}


resource "aws_lb_target_group" "api_tg" { #usada para definir um conjunto de recursos que o Load Balancer pode rotear tráfeg
  name     = "api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.porto_vpc.id
  target_type = "ip"
  health_check { #garante que o Load Balancer só envie tráfego para alvos que estão saudáveis.
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2 #verificações de integridade bem-sucedidas
    unhealthy_threshold = 2
    matcher             = "200"
  }
  tags = {
    Name = "ApiTargetGroup"
  }
}

resource "aws_lb_listener" "api_listener" { #responsável por escutar em uma porta e protocolo específicos, e por encaminhar o tráfego para um Target Group baseado em regras definidas.
  load_balancer_arn = aws_lb.api_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tg.arn
  }
}