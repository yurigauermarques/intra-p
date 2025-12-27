# Preparar a ISO

> Ainda nao foi válidado, apenas para proxima fase

## Baixar Ubuntu Server

wget https://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso

## Criar diretório para customização

```bash
mkdir -p ~/autoinstall-iso
```

- Estrutura de Arquivos

autoinstall-iso/
├── autoinstall.yaml
├── user-data          # (vazio ou com cloud-init adicional)
├── meta-data          # (vazio)
└── scripts/
    └── setup-ssh.sh

## Criar ISO Customizada (opcional)

```bash

# Extrair ISO original
sudo mount -o loop ubuntu-22.04.3-live-server-amd64.iso /mnt
cp -r /mnt ~/autoinstall-iso/
sudo umount /mnt

# Adicionar autoinstall.yaml
cp autoinstall.yaml ~/autoinstall-iso/

# Recriar ISO
genisoimage -o ubuntu-autoinstall.iso ~/autoinstall-iso/
```
