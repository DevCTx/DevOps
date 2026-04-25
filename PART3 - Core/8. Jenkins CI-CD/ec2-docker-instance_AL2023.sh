#!/bin/bash
#
# setup-prod.sh
# This script installs Docker and Docker Compose on the prod EC2 instance via SSM
# Amazon Linux 2023
#
aws ssm send-command \
  --document-name "AWS-RunShellScript" \
  --instance-ids <EC2-PROD-ID> \
  --region eu-west-3 \
  --parameters commands='[
    "dnf install -y docker",
    "systemctl enable docker",
    "systemctl start docker",
    "usermod -aG docker ec2-user",
    "mkdir -p /usr/local/lib/docker/cli-plugins",
    "curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose",
    "chmod +x /usr/local/lib/docker/cli-plugins/docker-compose",
    "mkdir -p /opt/app",
    "chown -R ec2-user:docker /opt/app"
  ]'
