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
sudo ufw allow 8080/tcp # Jenkins
sudo ufw allow 9093/tcp # Alertmanager
sudo ufw allow 9100/tcp # Node Exporter
echo "Portas abertas:"
sudo ufw --force enable
sudo ufw reload

echo "==> Instalando Docker..."
curl -fsSL https://get.docker.com | sh
sudo systemctl enable docker
sudo systemctl start docker

echo "==> Instalando Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# =====================================
# Configuração do Alertmanager / Telegram
# =====================================
if [[ "${CI}" == "true" ]]; then
    echo "⚙️ Ambiente CI detectado → Telegram desativado (usando valores fake)."
    usar_telegram="n"
else
    echo "==> Deseja configurar alertas via Telegram? (y/n)"
    read usar_telegram
fi

if [[ "$usar_telegram" == "y" ]]; then
    if [[ "${CI}" == "true" ]]; then
        BOT_TOKEN="FAKE_TOKEN"
        CHAT_ID="0000"
    else
        echo "👉 Informe o BOT TOKEN do Telegram:"
        read BOT_TOKEN
        echo "👉 Informe o CHAT ID do Telegram:"
        read CHAT_ID
    fi

    echo "==> Gerando configuração dinâmica do Alertmanager..."
    sed "s|__BOT_TOKEN__|$BOT_TOKEN|g; s|__CHAT_ID__|$CHAT_ID|g" alertmanager.yml.template > alertmanager.yml
else
    echo "⚠️  Telegram desativado. Criando config padrão sem integração."
    sed "s|__BOT_TOKEN__|FAKE_TOKEN|g; s|__CHAT_ID__|0000|g" alertmanager.yml.template > alertmanager.yml
fi

echo "==> Subindo containers (Nginx, MySQL/MariaDB, Prometheus, Grafana, Jenkins, Alertmanager, Node Exporter)..."
sudo docker-compose up -d --build

echo "======================================================"
echo " ✅ Setup concluído com sucesso! "
echo "======================================================"
echo "👉 Acesse os serviços:"
echo "- Nginx:      http://<IP-DA-SUA-VM>:80"
echo "- Grafana:    http://<IP-DA-SUA-VM>:3000 (login: admin / senha: admin)"
echo "- Prometheus: http://<IP-DA-SUA-VM>:9090"
echo "- Alertmanager: http://<IP-DA-SUA-VM>:9093"
echo "- MySQL/MariaDB: porta 3306"
echo "- Jenkins:    http://<IP-DA-SUA-VM>:8080"
echo
echo "💡 Assim que instalar o Grafana e Prometheus,"
echo "vocês já podem começar a coletar métricas da máquina (memória,"
echo "requisições, disco, rede, uptime e muito mais)."
