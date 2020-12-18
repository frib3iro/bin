#!/usr/bin/env bash
#----------------------------------------------------------------------
# Script    : [brutus.sh]
# Descrição : Script que permuta caracteres. 
# Descrição : Esse script pode ser usado como um passo inicial de um ataque brute force.
# Versão    : 1.0
# Autor     : Fabio Junior Ribeiro 
# Email     : rib3iro@live.com
# Github    : https://github.com/frib3iro 
# Data      : 18/12/2020
# Licença   : GNU/GPL v3.0
#----------------------------------------------------------------------
# Uso       :
#----------------------------------------------------------------------

# Vetor que representa o numero na base R.
VETORNUM=

# O R padrao eh 5 mas esse valor pode ser mudado pela opcao -r.
R=5

# Contera o alfabeto utilizado para gerar as permutacoes.
ALFABETO=

# Alfabetos padroes.
A1='abcdefghijklmnopqrstuvwxyz'
A2='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
A3='0123456789'

function helpme {
    echo 'brutus.sh : by Rib3iro'
    echo
    echo '[uso] ./brutus.sh [opcoes]'
    echo 'As opcoes sao:'
    echo '-h             Essa ajuda.'
    echo '-a             Alfabeto: [a-z].'
    echo '-A             Alfabeto: [A-Z].'
    echo '-d             Alfabeto: [0-9].'
    echo '-c <alfabeto>  Alfabeto customizado.'
    echo '-r <length>    Tamanho da saida (padrao: '$R').'
    exit 1
}

# Comando sem opcoes.
[ "$1" ] || helpme

# Tratando as opcoes da linha de comando.
while getopts 'haAdc:r:' OPT
do
    case $OPT in
        "h") helpme; exit ;;
        "a") ALFABETO=${ALFABETO}${A1} ;;
        "A") ALFABETO=${ALFABETO}${A2} ;;
        "d") ALFABETO=${ALFABETO}${A3} ;;
        "c") ALFABETO=${ALFABETO}${OPTARG} ;;
        "r") R=${OPTARG} ;;
        "?") echo 'Opcao invalida ou faltando argumento: '$OPT;
            echo 'Digite '$0' -h para mais ajuda.' ;
            exit 1 ;;
    esac
done

# Sai se nao foi fornecido nenhum alfabeto.
[ -z "$ALFABETO" ] && echo 'Sem alfabeto.' && exit 1

# N eh o tamanho de elementos do alfabeto.
N=${#ALFABETO}

while [ -z ${VETORNUM[R]} ]
do
    # O loop abaixo gera uma permutacao e a grava na variavel SAIDA.
    SAIDA=
    for (( i=0; i < R; i++ ))
    do
        index=${VETORNUM[i]}
        SAIDA=${ALFABETO:index:1}${SAIDA}
    done

    # Mostra a saida.
    echo $SAIDA

    # Incrementa a primeira posicao.
    let VETORNUM[0]++

    # Trata as carrys.
    for (( i=0; i < R; i++ ))
    do
        if [ "${VETORNUM[i]}" = "$N" ]
        then
            VETORNUM[i]=0 ;
            let VETORNUM[i+1]++ ;
        fi
    done
done

