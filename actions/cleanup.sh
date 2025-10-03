#!/bin/bash
set -e

echo "======================================================"
echo " Script de Limpeza da VM - DevOps Toolkit "
echo "======================================================"
echo

# Vai para o diretório HOME
cd ~

if [[ -d "devops-toolkit" ]]; then
    echo "==> Entrando no diretório devops-toolkit..."
    cd devops-toolkit
fi

if [[ "${CI}" == "true" ]]; then
    confirm="y"
else
    read -p "Deseja realmente limpar TUDO da máquina (containers, imagens, Nginx, apps antigas, pasta devops-toolkit)? [y/N]: " confirm
fi

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "==> Parando containers Docker..."
    sudo docker stop $(sudo docker ps -aq) || true
    sudo docker rm -f $(sudo docker ps -aq) || true

    echo "==> Removendo imagens e volumes Docker..."
    sudo docker system prune -af --volumes || true

    echo "==> Removendo Docker Compose antigo..."
    sudo rm -f /usr/local/bin/docker-compose

    echo "==> Removendo Nginx e pacotes antigos..."
    sudo systemctl stop nginx || true
    sudo apt remove --purge -y nginx nginx-common nginx-core || true
    sudo apt autoremove -y
    sudo apt clean

    echo "==> Limpando diretórios de aplicações antigas..."
    sudo rm -rf /var/www/*

    echo "==> Removendo pasta devops-toolkit..."
    cd ..
    rm -rf devops-toolkit

    echo "======================================================"
    echo " VM limpa com sucesso!"
    echo "👉 Agora pode reclonar o repositório:"
    echo "   git clone https://github.com/MnuelD/devops-toolkit.git && cd devops-toolkit && sudo actions/setup.sh"
    echo "======================================================"
else
    echo "==> Limpeza cancelada. Continuando com a instalação..."
    sudo actions/setup.sh
fi
