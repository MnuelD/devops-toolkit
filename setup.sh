#!/bin/bash
set -e

echo "======================================================"
echo " DevOps Toolkit - Instalação Automática "
echo "======================================================"

echo "==> Atualizando pacotes..."
sudo apt update
sudo apt install -y curl git apt-transport-https ca-certificates software-properties-common

echo "==> Instalando Docker..."
curl -fsSL https://get.docker.com | sh
sudo systemctl enable docker
sudo systemctl start docker

echo "==> Instalando Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)"     -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "==> Subindo containers (Nginx, MySQL/MariaDB, Prometheus, Grafana)..."
sudo docker-compose up -d --build

echo "======================================================"
echo " ✅ Setup concluído com sucesso! "
echo "======================================================"
echo "👉 Acesse os serviços:"
echo "- Nginx:      http://localhost:80"
echo "- Grafana:    http://localhost:3000 (login: admin / senha: admin)"
echo "- Prometheus: http://localhost:9090"
echo "- MySQL/MariaDB: porta 3306"
echo
echo "💡 Aproveitem! Assim que instalar o Grafana e Prometheus,"
echo "vocês já podem começar a dar métricas da máquina (memória,"
echo "requisições, disco duro e muito mais)."
