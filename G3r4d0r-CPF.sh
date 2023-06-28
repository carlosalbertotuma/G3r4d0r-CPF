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

Quantity=$1
StateCode=$2

# Função para calcular o dígito verificador
calculate_verifier() {
    local digits=$1
    local sum=0
    local multiplier=10

    for ((i=1; i<=${#digits}; i++)); do
        digit=${digits:i-1:1}
        sum=$((sum + digit * multiplier))
        multiplier=$((multiplier - 1))
    done

    remainder=$((sum % 11))
    if [ $remainder -lt 2 ]; then
        verifier=0
    else
        verifier=$((11 - remainder))
    fi

    echo "$verifier"
}

for ((i=1; i<=Quantity; i++)); do
    # Gera os oito primeiros dígitos do CPF
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

    # Calcula o primeiro dígito verificador
    first_verifier=$(calculate_verifier "$digits$state_digit")

    # Calcula o segundo dígito verificador
    second_verifier=$(calculate_verifier "$digits$state_digit$first_verifier")

    # Exibe o CPF completo
    cpf="${digits:0:3}.${digits:3:3}.${digits:6:3}$state_digit-$first_verifier$second_verifier"
    echo "$cpf"
done
