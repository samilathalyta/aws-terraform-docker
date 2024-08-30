# Projeto AWS Terraform Docker

Este repositório contém uma configuração de infraestrutura como código usando Terraform para provisionar recursos na AWS e configurar uma aplicação Dockerizada. 
O projeto inclui recursos como instâncias EC2, bancos de dados RDS, ECS para containers, e um Load Balancer.

## Estrutura do Projeto

O projeto é dividido em arquivos Terraform que configuram diversos recursos da AWS:

- **S3 Bucket**: Armazena o estado do Terraform.
- **EC2 Instance**: Provisiona uma instância EC2.
- **RDS Instance**: Cria uma instância de banco de dados MySQL.
- **ECS Cluster e Service**: Configura um cluster ECS e serviço para executar containers.
- **Load Balancer**: Configura um Application Load Balancer para distribuir o tráfego.
- **VPC e Subnets**: Define uma VPC e sub-redes públicas e privadas.
- **Security Groups**: Configura grupos de segurança para controle de acesso.

## Pré-requisitos

- **Terraform**: Certifique-se de ter o [Terraform](https://www.terraform.io/downloads.html) instalado.
- **AWS CLI**: Configure a [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) com suas credenciais AWS.
- **Git**: Utilize [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) para clonar e versionar o repositório.

## Configuração

1. **Clone o Repositório**

   Clone o repositório para o seu ambiente local:

   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git
   cd seu-repositorio
