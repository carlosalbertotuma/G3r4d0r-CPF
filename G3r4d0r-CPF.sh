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
echo "Use: ./G3r4d0r-CPF.sh quantidadeCPF"
echo "Exemplo: ./G3r4d0r-CPF.sh 10"
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

for ((i=1; i<=Quantity; i++)); do
    # Gera os nove primeiros dígitos do CPF
    digits=$(shuf -i 0-9 -n 9 | tr -d '\n')
  
    # Calcula o primeiro dígito verificador
    sum=0
    for ((j=1; j<=9; j++)); do
        digit=${digits:j-1:1}
        sum=$((sum + digit * (11 - j)))
    done
    first_verifier=$((11 - (sum % 11)))
    if [ $first_verifier -gt 9 ]; then
        first_verifier=0
    fi
  
    # Calcula o segundo dígito verificador
    digits="$digits$first_verifier"
    sum=0
    for ((j=1; j<=10; j++)); do
        digit=${digits:j-1:1}
        sum=$((sum + digit * (12 - j)))
    done
    second_verifier=$((11 - (sum % 11)))
    if [ $second_verifier -gt 9 ]; then
        second_verifier=0
    fi
  
    # Exibe o CPF completo
    cpf="${digits:0:3}.${digits:3:3}.${digits:6:3}-${first_verifier}${second_verifier}"
    echo "$cpf"
done
