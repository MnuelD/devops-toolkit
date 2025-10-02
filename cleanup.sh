#!/bin/bash
set -e

echo "======================================================"
echo " Script de Limpeza da VM - DevOps Toolkit "
echo "======================================================"
echo

if [[ "${CI}" == "true" ]]; then
    confirm="y"
else
    read -p "Deseja realmente limpar TUDO da máquina (containers, imagens, Nginx, apps antigas)? [y/N]: " confirm
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
    sudo rm -rf ~/devops-toolkit

    echo "==> VM limpa com sucesso!"
else
    echo "==> Limpeza cancelada. Continuando com a instalação..."
fi
