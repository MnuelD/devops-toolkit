# DevOps Toolkit 🚀

Automação completa para configurar rapidamente **Docker + Nginx + MySQL/MariaDB + Prometheus + Grafana** em uma VM Linux.  
também com **Dashboards prontos para Grafana (CPU, Memória, Disco, Rede e Uptime)** e suporte a **alertas via Telegram**.

---

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

Após a limpeza total, reclona de forma automática o repositório e então basta rodar o setup:

```bash
chmod +x actions/cleanup.sh
chmod +x actions/setup.sh
sudo actions/setup.sh
```

- Se **responder NÃO (n)** → ele pula a limpeza completa, remove apenas o essencial e segue direto para o `setup`:

```bash
chmod +x actions/cleanup.sh
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

## 🔓 Habilitar portas no firewall
- **nginx**: `sudo ufw allow 80/tcp`  
- **mysql**: `sudo ufw allow 3306/tcp`  
- **grafana**: `sudo ufw allow 3000/tcp`  
- **prometheus**: `sudo ufw allow 9090/tcp`  

---

## 📊 Serviços disponíveis
- Nginx: http://<IP-DA-SUA-VM>:80  
- Grafana: http://<IP-DA-SUA-VM>:3000 (admin/admin)  
- Prometheus: http://<IP-DA-SUA-VM>:9090  
- Jenkins: http://<IP-DA-SUA-VM>:8080 (admin/admin)  
- Alertmanager: http://<IP-DA-SUA-VM>:9093  
- MySQL/MariaDB: porta 3306  

💡 Assim que instalar o Grafana e Prometheus, você já pode monitorar métricas da própria VM como **memória, disco, rede e requisições**.

---

## 📈 Dashboards prontos (Node Exporter)

Este toolkit já traz um **dashboard otimizado para Grafana** (`node_exporter.json`) com os principais gráficos:

- CPU  
- Memória  
- Disco  
- Rede  
- Uptime  

### Importar dashboard automaticamente:
Execute:

```bash
chmod +x actions/import_dashboard.sh
./actions/import_dashboard.sh
```

👉 Isso fará a importação automática no Grafana (via API).  

### Importar manualmente:
1. Acesse o Grafana → Dashboards → Import.  
2. Clique em **Upload JSON**.  
3. Selecione o arquivo `dashboards/node_exporter.json`.  
4. Pronto! 🎉  

---

## 🔔 Alertas com Telegram

Este toolkit suporta envio de alertas do **Prometheus → Alertmanager → Telegram**.

### ⚙️ Configuração

1. Crie um bot no Telegram com o [@BotFather](https://t.me/BotFather) e copie o **bot_token**.  
2. Obtenha o **chat_id** do seu grupo ou chat:  
   - Adicione o bot ao grupo/canal.  
   - Envie qualquer mensagem.  
   - Acesse no navegador:  
     ```
     https://api.telegram.org/bot<SEU_TOKEN>/getUpdates
     ```
   - No JSON retornado, copie o campo `chat.id`.  
3. Durante a execução do `setup.sh`, você pode escolher se deseja **ativar os alertas via Telegram**.  
   - Se escolher **SIM**, o script vai pedir o **bot_token** e o **chat_id**, e gerar automaticamente o arquivo `alertmanager.yml`.  
   - Se escolher **NÃO**, os alertas serão ignorados.  

---

### 📌 Onde alterar depois
Caso queira ajustar manualmente:  
- Arquivo: `alertmanager.yml`  
- Campos a editar:
  ```yaml
  bot_token: "<SEU_TOKEN_AQUI>"
  chat_id: "<SEU_CHAT_ID_AQUI>"
  ```

---
