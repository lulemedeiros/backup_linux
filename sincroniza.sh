#!/bin/bash

while : ; do

    # Setando variaveis...
    # Usuário, origem e destino da cópia
    o_user=$(whoami)
    o_origem=/home/$o_user/
    d_destin=/mnt/1TERA/$o_user/ # Aqui eu setei no meu linux que eu quero que o HD Externo seja mapeado no cerregamento do sistema com o nome de 1TERA

    # O que não copiar setado no arquivo txt, pode ser nome do arquivo ou de uma pasta, então, se colocar no arquivo para não copiar o arquivo
    # .tmp ele não ira copiar nem aquivo nem pasta com esse nome, um nome por linha no txt, também pode ser um caminho ex. /home/lixo
    nao_copiar=/mnt/1TERA/nao_copiar.txt

    # Configurações do aviso da vaquinha do comando xcowsay
    conf_xcowsay="--time=4 --cow-size=small --reading-speed=2"

    # Entra em um loop de verificação e avisa se a pasta de destino do backup não for encontrada e sai do script encerrando.
  if [ ! -d $d_destin ]; then
    xcowsay $conf_xcowsay " O diretório de destino do backup não foi encontrado! "
    exit 1
  fi

    # Usa um arquivo de lock para impedir execução simultânea.
    # Caso a execução leve mais do que sessenta segundos.

  if [[ ! -e /tmp/lockfile ]]; then
    touch /tmp/lockfile
    {

    # Começo do código a ser loopado.
    # Seta e desmonta a data.

  ini_da_syc=" Iniciando a sincronizacao do backup! "
  fim_da_syc=" Sincronização de backup concluída! "

  sl | lolcat
  cowsay $ini_da_syc | lolcat

    figlet -w 150 Script de Backup do Lule | lolcat
    sleep 5s
  	rsync -avzP --delete --exclude-from=$nao_copiar $o_origem $d_destin

  sl | lolcat
  cowsay $fim_da_syc | lolcat

    # Pasta deve estar sincronizada, aguardando próximo loop.
    # Fim do código a ser loopado.

      rm /tmp/lockfile
    } &    # Note o "&" para execução em background.
  fi

  clear

  sleep 1600 # Aqui determino os segundos para cada loop.

  clear

done
