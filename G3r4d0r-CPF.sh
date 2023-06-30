#!/bin/bash
banner()
{
echo
echo ' ######    #######  ########  ##        ########    #####   ########           ######  ########  ######## '
echo '##    ##  ##     ## ##     ## ##    ##  ##     ##  ##   ##  ##     ##         ##    ## ##     ## ##       '
echo '##               ## ##     ## ##    ##  ##     ## ##     ## ##     ##         ##       ##     ## ##       '
echo '##   ####  #######  ########  ##    ##  ##     ## ##     ## ########  ####### ##       ########  ######   '
echo '##    ##         ## ##   ##   ######### ##     ## ##     ## ##   ##           ##       ##        ##       '
echo '##    ##  ##     ## ##    ##        ##  ##     ##  ##   ##  ##    ##          ##    ## ##        ##       '
echo ' ######    #######  ##     ##       ##  ########    #####   ##     ##          ######  ##        ##       '
echo 
echo "Use: ./G3r4d0r-CPF.sh quantidadeCPF Estado"
echo "Exemplo: ./G3r4d0r-CPF.sh 10 SP"
echo
echo "Version 2.0"
echo '  _                             _             __             '
echo ' /  ._ _   _| o _|_  _   _ o   |_) | |_|_ _| (_   _ |_|_ ._  '
echo ' \_ | (/_ (_| |  |_ (_) _> o   |_) |   | (_| __) (_   |  | | '
echo
echo -e "\e[1;37mLivre uso e modificacao, mantenha os creditos em comentario.\e[0m"
echo -e "\e[1;31mPs: Nao faca teste em dominios sem permissao\e[0m"
}

# Verifica se todos os três argumentos foram passados
if [ $# -lt 1 ]; then
  banner
  exit 1
fi

#!/bin/bash

Quantity=$1
StateCode=$2

generated=0
while [ $generated -lt $Quantity ]; do
    # Gera os primeiros oito dígitos aleatórios
    digits=$(shuf -i 0-9 -n 8 | tr -d '\n')

    # Obtém o dígito do estado
    case $StateCode in
        "DF"|"GO"|"MS"|"TO") state_digit=1;;
        "PA"|"AM"|"AC"|"AP"|"RO"|"RR") state_digit=2;;
        "CE"|"MA"|"PI") state_digit=3;;
        "PE"|"RN"|"PB"|"AL") state_digit=4;;
        "BA"|"SE") state_digit=5;;
        "MG") state_digit=6;;
        "RJ"|"ES") state_digit=7;;
        "SP") state_digit=8;;
        "PR"|"SC") state_digit=9;;
        "RS") state_digit=0;;
        *) state_digit=0;;
    esac

    # Gera os dois últimos dígitos aleatórios
    last_digits=$(shuf -i 0-9 -n 2 | tr -d '\n')

    # Calcula a soma dos dígitos, incluindo o dígito do estado
    digits_sum=$((10#${digits:0:1} + 10#${digits:1:1} + 10#${digits:2:1} + 10#${digits:3:1} + 10#${digits:4:1} + 10#${digits:5:1} + 10#${digits:6:1} + 10#${digits:7:1} + state_digit + 10#${last_digits:0:1} + 10#${last_digits:1:1}))

    # Verifica se a soma é igual a 44 ou 55
    if [ $digits_sum -eq 44 ] || [ $digits_sum -eq 55 ]; then
        # Formata o CPF no padrão 000.000.000-00
        cpf="${digits:0:3}.${digits:3:3}.${digits:6:3}-${state_digit}${last_digits}"

        # Exibe o CPF formatado
        echo "$cpf"
        generated=$((generated + 1))
    fi
done
