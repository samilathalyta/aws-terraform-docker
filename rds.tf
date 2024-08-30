#RDS INSTANCE
resource "aws_db_instance" "portoshop_database" {
  identifier                  = "portoshop-database-instance"
  engine                      = "mysql"
  instance_class              = "db.t3.micro" # tipo de instância qualificado para a camada gratuita
  engine_version              = "8.0.32"      # versão suportada com a t2micro
  allocated_storage           = 20            # Armazenamento em GB (dentro da camada gratuita)
  db_name                     = "rdsportoshop"
  username                    = "admin"
  password                    = var.db_password #variavel de amb criado no prompt set TF_VAR_db_password=***
  storage_encrypted           = true            # Criptografa o armazenamento da instância RDS - protege dados
  apply_immediately           = true            # Aplica as mudanças imediatamente
  allow_major_version_upgrade = true            # Permite atualizações de versão principal


  skip_final_snapshot = true  # não criar um snapshot final ao excluir a instância p evitar custos
  publicly_accessible = false # instância não acessível publicamente
  vpc_security_group_ids      = [aws_security_group.ec2_security.id]

  tags = {
    Name        = "RdsPortoShop"
    Environment = "Dev"
  }
}