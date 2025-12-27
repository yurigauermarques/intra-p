usuario ansible_user renomar para ansible

/var/www/projeto 
    -  permissão para o ansible_user
-  

upgrade para symfony 7.3

instalar APCU



Minha Sugestão de Ordem:

    Habilitar HTTPS com Let's Encrypt: É rápido, essencial e dá um grande retorno em segurança.
    Deploy da Aplicação via Git: Muda completamente a forma como você gerencia o código da sua aplicação.
    Backup do Banco de Dados: Proteja seus dados o mais rápido possível.
    Gerenciamento de Atualizações: Uma tarefa de manutenção contínua e vital.
    Monitoramento: Quando sua aplicação se tornar mais crítica.

Qual desses tópicos te parece mais interessante para explorarmos agora?



Melhorias

- Fail2ban
  - Criar Jail especifica pra o symfony
    Você modifica o código Symfony para registrar falhas de login.
    Você cria um filtro no Ansible que ensina o Fail2ban a ler esse registro.
    Você atualiza seu playbook para copiar o filtro e ativar a nova "jail", dizendo a ela onde encontrar o arquivo de log do Symfony.