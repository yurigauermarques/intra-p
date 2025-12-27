# Instalacaos

## Utilitários

[x] echo "usario ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/usuario
[ ] sudo apt install
        [x] vim
        [x] nano
        [x] curl
        [x] make
        [x] nfs-common # cliente NFS
        [x] net-tools # Inspeção e configuração de redes (ex.: ifconfig, netstat, route, arp, nameif, rarp).
        [x] cifs-utils # Montar compartilhamento para o SAMBA
        [x] ca-certificates
        [x] nmap # scanner de rede/hosts para autitoria de segurança
        [x] sshpass # ferramenta util pra acesso ssh
        --yes

## Utilitários (Remoto)

<!-- VPN ver melhor forma -->
sudo apt install resolvconf wireguard --yes
sudo wg-quick up ~/$USER.conf
sudo wg-quick down ~/$USER.conf

## Driver (Opcional)

[x] sudo ubuntu-drivers autoinstall
<!-- Desabilitando o Wayland, habilitando o X, X11, X.org ou XORG -->
[ ]sudo sed -i "s@#WaylandEnable=false@WaylandEnable=false@g" /etc/gdm3/custom.conf
<!-- necessario para hora do dualboot -->
[ ]timedatectl set-local-rtc 1 --adjust-system-clock

## UFW

[x] sudo sed -i "s@IPV6=yes@IPV6=no@g" /etc/default/ufw
[x] sudo ufw default deny incoming
[x] sudo ufw default allow outgoing
[x] sudo ufw allow from "172.16.0.0/12"
[x] sudo ufw enable

## Java

[ ]sudo apt install openjdk-21-jdk --yes
<!-- java --version -->

## SSH

<!-- Substituida por downlod da chave(ver melhor caso) -->
[x]ssh-keygen -q -t rsa -P "" -f ~/.ssh/id_rsa -C "email@email"
<!-- cat ~/.ssh/id_rsa.pub -->

<!-- Substituir pelo download do config completo -->
[x] cat <<EOF | tee ~/.ssh/config
    Host *
    ServerAliveInterval 180
    ServerAliveCountMax 3
    PubkeyAcceptedAlgorithms +ssh-rsa
    HostkeyAlgorithms +ssh-rsa
    KexAlgorithms +diffie-hellman-group1-sha1
    EOF

[x]chmod 600 ~/.ssh/id_rsa
[x]chmod 644 ~/.ssh/id_rsa.pub
[x]chmod 600 ~/.ssh/config

## Teleport

curl -O https://cdn.teleport.dev/teleport-v16.4.7-linux-amd64-bin.tar.gz
tar -xzf teleport-v16.4.7-linux-amd64-bin.tar.gz
cd teleport
sudo ./install
tsh login --proxy=teleport.al.mt.gov.br
tsh ls
tsh ssh swarm-master-01-pre-stage

## Mongo Compass

https://www.mongodb.com/docs/compass/master/install/
wget https://downloads.mongodb.com/compass/mongodb-compass_1.44.6_amd64.deb

## GIT*

[x]sudo apt install git --yes
[x]git config --global user.name "Usuario"
[x]git config --global user.email "email@email"
[x]git config --global core.editor nano
[x]git config --global pager.branch false

## Docker

[x] Docker

    ```bash
    https://docs.docker.com/engine/install/ubuntu/
    sudo apt-get remove docker docker-engine docker.io containerd runc
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o
    /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg]
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin
    docker-compose-plugin --yes
    sudo usermod -aG docker $USER
    su - $USER
    docker run hello-world
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    ```

[x] docker --version


## Docker Compose

[x] Docker Compose

    ```bash
    sudo mkdir -p /usr/local/lib/docker/cli-plugins
    sudo curl -SL
    "https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-linux-x86_64"
    -o /usr/local/lib/docker/cli-plugins/docker-compose
    sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
    sudo ln -s /usr/local/lib/docker/cli-plugins/docker-compose /usr/bin/docker-compose
    docker-compose --version
    ```

[x] docker compose version

## Chave SSH compartilhada no contêiner

eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa

## Kubectl

> https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
> https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o
/etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg]
https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee
/etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install kubectl --yes

## Snapd

sudo snap install mysql-workbench-community
sudo snap connect mysql-workbench-community:password-manager-service
sudo snap connect mysql-workbench-community:ssh-keys
sudo snap connect mysql-workbench-community:cups-control
sudo snap install vlc
sudo snap install discord
sudo snap connect discord:system-observe
sudo snap install postman
sudo snap install dbeaver-ce
sudo snap install code --classic
sudo snap install kontena-lens --classic
sudo snap install redisinsight
Snapd Extension
 <!-- Docker -->
code --install-extension "ms-azuretools.vscode-docker"
<!--  PHP -->
code --install-extension "bmewburn.vscode-intelephense-client"
code --disable-extension "vscode.php-language-features"
code --install-extension "xdebug.php-debug"
code --install-extension "xdebug.php-pack"
<!-- Outros -->
code --install-extension "ecmel.vscode-html-css"
code --install-extension "junstyle.php-cs-fixer"
code --install-extension "redhat.vscode-yaml"
code --install-extension "redhat.vscode-xml"
code --install-extension "mehedidracula.php-namespace-resolver"
code --install-extension "mikestead.dotenv"
code --install-extension "yzhang.markdown-all-in-one"
code --install-extension "Glavin001.unibeautify-vscode"

## VirtualBox

sudo mkdir --parents --verbose /etc/vbox
cat <<EOF | sudo tee /etc/vbox/networks.conf
* 172.31.255.0/24
EOF
Link
## https://www.virtualbox.org/wiki/Linux_Downloads
https://download.virtualbox.org/virtualbox/7.1.4/virtualbox-7.1_7.1.4-165100~Ubuntu~noble_a
md64.deb
Repo
echo deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox.gpg]
http://download.virtualbox.org/virtualbox/debian jammy contrib | sudo tee
/etc/apt/sources.list.d/virtualbox.list
curl -fSsL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor |
sudo tee /usr/share/keyrings/virtualbox.gpg > /dev/null
sudo apt update
sudo apt install virtualbox-7.0 --yes

## Vagrant

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg]
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee
/etc/apt/sources.list.d/hashicorp.list
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o
/usr/share/keyrings/hashicorp-archive-keyring.gpg
sudo apt update
sudo apt install vagrant --yes
vagrant box add debian/bookworm64

## Helm

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee
/usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg]
https://baltocdn.com/helm/stable/debian/ all main" | sudo tee
/etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install helm --yes