variable "db_password" {
  description = "A senha para o RDS instance"
  type        = string
  sensitive   = true
}