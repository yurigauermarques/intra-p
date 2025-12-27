# 🏗️ Infraestrutura como Código

Projeto completo para gerenciamento automatizado de estação de trabalho e servidores VPS usando **Ansible**.

## � Visão Geral

Este repositório contém scripts e playbooks para automação de infraestrutura, desde a configuração inicial até o gerenciamento contínuo da estação de trabalho e de pequenos servidores.

## 📁 Estrutura do Projeto

```text
infra-p/
├── ansible/                          # Automação com Ansible
│   ├── roles/                        # Roles organizados por função
│   │   ├── common/                  # Configurações básicas do sistema
│   │   ├── docker/                  # Docker + Docker Compose
│   │   ├── fail2ban/                # Proteção contra ataques
│   │   ├── firewall/                # Configuração UFW
│   │   ├── nginx/                   # Servidor web Nginx
│   │   ├── node/                    # Node.js + Yarn
│   │   ├── php/                     # PHP 8.1/8.4 + extensões
│   │   └── postgresql/              # Banco PostgreSQL
│   ├── vars/                        # Variáveis e secrets
│   │   └── secrets.yml              # Senhas (criptografadas)
│   ├── configurar_vps.yml           # Playbook para servidores VPS
│   ├── configurar_station.yml       # Playbook para estação local
│   ├── configurar_station_24_04.yml # Playbook para Ubuntu 24.04
│   ├── hosts.ini                    # Inventário de hosts remotos
│   ├── hosts_local.ini              # Inventário para localhost
│   └── ansible.cfg                  # Configurações do Ansible
├── init/                            # Scripts de inicialização
│   ├── autoinstall.yaml            # Configuração de autoinstalação
│   └── vpn/                        # Configurações VPN
└── README.md                       # Esta documentação
```

## 🛠️ Automação com Ansible

### 🎭 **Roles Disponíveis**

- **`common`** - Configurações básicas do sistema (pacotes essenciais, timezone, etc)
- **`docker`** - Docker + Docker Compose + configuração de usuários
- **`fail2ban`** - Proteção contra força bruta e ataques automatizados
- **`firewall`** - UFW (Uncomplicated Firewall) + regras de segurança
- **`nginx`** - Servidor web + configuração de sites + PHP-FPM
- **`node`** - Node.js (via NVM) + Yarn
- **`php`** - PHP 8.1/8.4 + extensões + otimizações
- **`postgresql`** - Banco de dados + usuários + permissões

### 📋 **Playbooks Disponíveis**

#### **1. `configurar_vps.yml`** - Servidor VPS

Configura um servidor VPS completo com:

- Configurações básicas (common)
- Firewall + Fail2ban
- PHP + Nginx
- PostgreSQL
- Node.js

#### **2. `configurar_station.yml`** - Estação de Trabalho

Configura uma estação de trabalho local com:

- Firewall (com regras customizadas)
- PHP para desenvolvimento
- Node.js
- Docker

#### **3. `configurar_station_24_04.yml`** - Ubuntu 24.04

Playbook otimizado para Ubuntu 24.04 LTS

### 🔐 **Gerenciamento de Secrets**

```bash
# Trocar a senha do vault (senha default 123456)
ansible-vault rekey ansible/vars/secrets.yml

# Criar arquivo de senhas criptografado
ansible-vault create vars/secrets.yml

# Editar arquivo de senhas criptografado
ansible-vault edit vars/secrets.yml

# Executar playbook com senhas
ansible-playbook -i hosts.ini configurar_vps.yml -u ansible_user --ask-vault-pass
```

### 🛡️ **Proteção com Fail2ban**

O projeto inclui configuração robusta do **Fail2ban** para proteção contra ataques:

#### **Configurações Padrão:**

- **Tempo de banimento**: 1 hora
- **Janela de detecção**: 10 minutos  
- **Tentativas máximas**: 5 antes do banimento
- **Ação**: Bloqueio automático via UFW

#### **Serviços Protegidos:**

- ✅ **SSH** - Proteção contra força bruta
- ✅ **Nginx** - Proteção HTTP/HTTPS (configurável)
- ✅ **PHP-FPM** - Proteção contra ataques web (configurável)

#### **Comandos Úteis:**

```bash
# Ver status do Fail2ban
sudo fail2ban-client status

# Ver IPs banidos para SSH
sudo fail2ban-client status sshd

# Desbanir um IP específico
sudo fail2ban-client set sshd unbanip 179.217.102.72

# Ver logs do Fail2ban
sudo tail -f /var/log/fail2ban.log

# Verificar regras UFW criadas pelo Fail2ban
sudo ufw status numbered
```

#### **Personalização:**

Para ajustar as configurações do Fail2ban, edite as variáveis:

```yaml
# ansible/roles/fail2ban/defaults/main.yml
fail2ban_bantime: 1h      # Tempo de banimento
fail2ban_findtime: 10m    # Janela de detecção
fail2ban_maxretry: 5      # Tentativas máximas
fail2ban_jails:           # Serviços protegidos
  - sshd
  - nginx-http-auth
  - nginx-limit-req
```

## � Como Usar

### 1️⃣ **Configurar Servidor VPS**

```bash
# 1. Configure o inventário de hosts
vim ansible/hosts.ini

# 2. Configure secrets (senhas, chaves, etc)
ansible-vault create ansible/vars/secrets.yml

# 3. Execute o playbook para VPS
cd ansible/
ansible-playbook -i hosts.ini configurar_vps.yml -u ansible_user --ask-vault-pass
```

### 2️⃣ **Configurar Estação Local**

```bash
# Execute o playbook localmente
cd ansible/
ansible-playbook -i hosts_local.ini configurar_station_24_04.yml --ask-become-pass
```

### 3️⃣ **Editar Secrets Existentes**

```bash
# Editar secrets
ansible-vault edit ansible/vars/secrets.yml

# Visualizar secrets
ansible-vault view ansible/vars/secrets.yml
```


## 📚 Documentação Adicional

- [ansible/util.md](ansible/util.md) - Comandos úteis para administração
- [ansible/penencias.md](ansible/penencias.md) - Pendências e melhorias futuras
- [ANSIBLE_LOCAL.md](ANSIBLE_LOCAL.md) - Guia de uso local do Ansible
- [ubuntu-2404.md](ubuntu-2404.md) - Notas específicas para Ubuntu 24.04

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.
