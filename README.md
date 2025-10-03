# DevOps Toolkit 🚀

Automação completa para configurar rapidamente **Docker + Nginx + MySQL/MariaDB + Prometheus + Grafana** em uma VM Linux.

## ✨ Autor
**Desenvolvido por Manuel Dala**  
Aproveitem esta ferramenta e compartilhem com a comunidade DevOps 🚀

---

## 📦 Pré-requisitos
- Ubuntu Server 20.04+ (VM limpa ou já em uso)
- Acesso via SSH
- Git

---

## 🧹 Passo 1: Limpeza (opcional)
Antes da instalação, você pode executar a limpeza total da VM:

➡️ O script vai perguntar se você deseja **apagar tudo** (containers, imagens, volumes, Nginx e apps antigas).  

- Se **responder SIM (y)** → sua VM ficará **completamente zerada** (modo "virgem") e você precisará **reclonar o repositório**:

```bash
git clone https://github.com/MnuelD/devops-toolkit.git
cd devops-toolkit
chmod +x actions/cleanup.sh
chmod +x actions/setup.sh
sudo actions/cleanup.sh
```

Após a limpeza total, reclone e rode o setup:

```bash
git clone https://github.com/MnuelD/devops-toolkit.git
cd devops-toolkit
chmod +x actions/setup.sh
sudo actions/setup.sh
```

- Se **responder NÃO (n)** → ele pula a limpeza completa, remove apenas o essencial e segue direto para o `setup`:

```bash
chmod +x actions/setup.sh
sudo actions/setup.sh
```

---

## 🚀 Passo 2: Instalar stack completa
Se já estiver no repositório e não quiser limpar, basta executar:

```bash
chmod +x actions/setup.sh
sudo actions/setup.sh
```

---

## habilitar Portas 
- **nginx**: sudo ufw allow 80/tcp
- **mysql**: sudo ufw allow 3306/tcp
- **grafana**: sudo ufw allow 3000/tcp
- **prometheus**: sudo ufw allow 9090/tcp



## 📊 Serviços disponíveis
- Nginx: http://<IP-DA-SUA-VM>:80
- Grafana: http://<IP-DA-SUA-VM>:3000 (admin/admin)
- Prometheus: http://<IP-DA-SUA-VM>:9090
- Jenkins: http://<IP-DA-SUA-VM>:8080 (admin/admin)
- Alertmanager: http://<IP-DA-SUA-VM>:9093
- MySQL/MariaDB: porta 3306  

💡 Assim que instalar o Grafana e Prometheus, você já pode monitorar métricas da própria VM como **memória, disco, rede e requisições**.

---

