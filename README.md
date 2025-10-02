# DevOps Toolkit 🚀

Automação completa para configurar rapidamente **Docker + Nginx + MySQL/MariaDB + Prometheus + Grafana** em uma VM Linux.

---

## 📦 Pré-requisitos
- Ubuntu Server 20.04+ (VM limpa ou já em uso)
- Acesso via SSH
- Git

---

## 🧹 Passo 1: Limpeza (opcional)
Antes da instalação, você pode executar a limpeza total da VM:

```bash
chmod +x cleanup.sh
./cleanup.sh
```

➡️ O script vai perguntar se você deseja **apagar tudo** (containers, imagens, volumes, Nginx e apps antigas).  
Se não quiser, pode pular e ir direto para a instalação.

---

## 🚀 Passo 2: Instalar stack completa
Clone o repositório e execute o setup:

```bash
git clone https://github.com/seu-usuario/devops-toolkit.git
cd devops-toolkit
chmod +x setup.sh
./setup.sh
```

---

## 📊 Serviços disponíveis
- **Nginx:** http://localhost:80  
- **Grafana:** http://localhost:3000 (admin / admin)  
- **Prometheus:** http://localhost:9090  
- **MySQL/MariaDB:** porta `3306`  

💡 Assim que instalar o Grafana e Prometheus, você já pode monitorar métricas da própria VM como **memória, disco, rede e requisições**.

---

## ✨ Autor
**Desenvolvido por Manuel Dala**  
Aproveitem esta ferramenta e compartilhem com a comunidade DevOps 🚀
