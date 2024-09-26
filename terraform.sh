#!/bin/bash

# Carrega as variáveis do arquivo .env
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "[terraform] Erro: Arquivo .env não encontrado."
    exit 1
fi

# Verifica se o método foi passado como argumento
if [ -z "$1" ]; then
    echo "[terraform] Erro: Nenhum método especificado (plan, apply, etc.)."
    exit 1
fi

METHOD=$1
shift

PARAMS="$@"

terraform $METHOD $PARAMS \
-var "environment=$ENVIRONMENT" \
-var "image_name=$IMAGE_NAME" \
-var "image_username=$DOCKERHUB_USERNAME" \
-var "image_version=$IMAGE_VERSION" \
-var "enable_flyway=false" \
-var "aws_region=$AWS_REGION" \
-var "vpc_name=$VPC_NAME" \
-var "subnet_availability_zone_az_1=$SUBNET_AVAILABILITY_ZONE_AZ_1" \
-var "subnet_availability_zone_az_2=$SUBNET_AVAILABILITY_ZONE_AZ_2" \
-var "db_username=$DB_USERNAME" \
-var "db_password=$DB_PASSWORD" \
-var "db_name=$DB_NAME" \
-var "db_host=$DB_HOST" \
-var "bucket_food_lambdas=$LAMBDA_BUCKET_NAME"
