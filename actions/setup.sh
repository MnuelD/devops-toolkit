#!/bin/bash
set -e

echo "======================================================"
echo " DevOps Toolkit - Instalação Automática "
echo "======================================================"

echo "==> Atualizando pacotes..."
sudo apt update
sudo apt install -y curl git apt-transport-https ca-certificates software-properties-common ufw

echo "==> Configurando firewall (UFW)..."
sudo ufw allow 22/tcp   # SSH
sudo ufw allow 80/tcp   # Nginx
sudo ufw allow 3306/tcp # MySQL/MariaDB
sudo ufw allow 3000/tcp # Grafana
sudo ufw allow 9090/tcp # Prometheus
sudo ufw --force enable
sudo ufw reload

echo "==> Instalando Docker..."
curl -fsSL https://get.docker.com | sh
sudo systemctl enable docker
sudo systemctl start docker

echo "==> Instalando Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "==> Subindo containers (Nginx, MySQL/MariaDB, Prometheus, Grafana, Jenkins)..."
sudo docker-compose up -d --build

echo "======================================================"
echo " ✅ Setup concluído com sucesso! "
echo "======================================================"
echo "👉 Acesse os serviços:"
echo "- Nginx:      http://<IP-DA-SUA-VM>:80"
echo "- Grafana:    http://<IP-DA-SUA-VM>:3000 (login: admin / senha: admin)"
echo "- Prometheus: http://<IP-DA-SUA-VM>:9090"
echo "- MySQL/MariaDB: porta 3306"
echo
echo "💡 Aproveitem! Assim que instalar o Grafana e Prometheus,"
echo "vocês já podem começar a dar métricas da máquina (memória,"
echo "requisições, disco duro e muito mais)."
