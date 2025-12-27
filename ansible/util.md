# Configuração

## Local

```bash
# Atualiza seus pacotes
sudo apt update;

# Instala dependências para adicionar novos repositórios
sudo apt install software-properties-common;

# Adiciona o repositório oficial do Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible;

# Instala o Ansible
sudo apt install ansible;
```

## VPS

- Crie o usuario na vps
  
```bash
adduser ansible
usermod -aG sudo ansible
sudo visudo
#Adicionar depois da linha `%sudo   ALL=(ALL:ALL) ALL`
ansible ALL=(ALL) NOPASSWD:ALL


```

- Adicione a chave ssh pro usuario criado

```bash
ssh-copy-id ansible@72.60.156.142
```

- Testar configuração

```bash 
ansible -i hosts.ini vps -m ping -u ansible
```


# Execução de playbook

```bash
#executar
ansible-playbook -i hosts.ini configurar_vps.yml -u ansible
ansible-playbook -i hosts.ini configurar_vps.yml -u ansible --ask-vault-pass

ansible-playbook -i hosts_local.ini configurar_local.yml --limit localhost

# secrets
ansible-vault create vars/secrets.yml
ansible-vault view vars/secrets.yml

```

# Comandos Úteis de Usuários e Grupos

## Verificar grupos de um usuário

```bash
# Ver grupos do usuário atual
groups

# Ver grupos de um usuário específico
groups ansible
groups ubuntu

# Informações detalhadas do usuário
id ansible

# Ver todos os grupos que o usuário pertence (formato detalhado)
id -Gn ansible
```

## Listar usuários do sistema

```bash
# Listar todos os usuários
cut -d: -f1 /etc/passwd

# Listar apenas usuários humanos (UID >= 1000)
awk -F: '$3 >= 1000 {print $1}' /etc/passwd

# Ver usuários com shell de login
grep -E '/bin/(bash|sh|zsh)$' /etc/passwd | cut -d: -f1
```

## Listar grupos do sistema

```bash
# Listar todos os grupos
cut -d: -f1 /etc/group

# Ver membros de um grupo específico
getent group sudo
getent group www-data
```

## Verificar privilégios sudo

```bash
# Ver configurações sudo do usuário
sudo -l -U ansible

# Testar se usuário pode usar sudo
sudo -n -l -U ansible
```
