.data
Menu: .asciiz "\n1 - Inserir\n2 - Consultar\n3 - Remover\n4 - Sair\n"
Input: .asciiz "Informe um numero: "
ListaVazia: .asciiz "Lista vazia!\n"
Valor: .asciiz "Valor: "
Newline: .asciiz "\r\n"

.text
main:
    li $s0, 0 # Ponteiro inicial da lista
menu:
    la $a0, Menu # Carrega o endereco da string
    li $v0, 4 # Codigo de impressao de string
    syscall # Imprime a string
    li $v0, 5 # Codigo de leitura de inteiro
    syscall # Le o inteiro
    la $ra, menu # Definir retorno para o menu
    beq $v0, 1, insercao
    beq $v0, 2, consulta
    beq $v0, 3, remocao
    beq $v0, 4, saida
    j menu
    
listavazia:
    la $a0, ListaVazia # Carrega o endereco da string
    li $v0, 4 # Codigo de impressao de string
    syscall # Imprime a string
    jr $ra # Retorna para a main
    
obterultimo:
    move $v0, $s0 # Carrega o endereco da lista
    li $v1, 0 # Endereco anterior
ob_loop:
    lw $t1, 4($v0) # Carrega o endereco da proxima celula
    beqz $t1, ob_retorno # Retornar o endereco se o proximo for NULL
    move $v1, $v0 # Salvar anterior
    move $v0, $t1 # Ir para o proximo endereco
    j ob_loop
ob_retorno:
    jr $ra # Retornar para o caller
    
insercao:
    subi $sp, $sp, 4 # Reserva um espaco na pilha
    sw $ra, ($sp) # Guarda o endereco de retorno na pilha
    la $a0, Input # Carrega o endereco da string
    li $v0, 4 # Codigo de impressao de string
    syscall # Imprime a string
    li $v0, 5 # Codigo de leitura de inteiro
    syscall # Le o inteiro
    move $t0, $v0 # Guarda o inteiro
    li $a0, 8 # Espaco de 8 bytes para uma celula da lista
    li $v0, 9 # Codigo de alocacao dinamica
    syscall # Aloca uma celula
    sw $t0, ($v0) # Guarda o inteiro na celula
    sw $zero, 4($v0) # Apontar o proximo para NULL
    beqz $s0, inicializacao # Se a lista estiver vazia, apontar para a propria celula
    move $t0, $v0 # Guarda a celula
    jal obterultimo # Obtem o endereco da ultima celula da lista
    sw $t0, 4($v0) # Aponta a ultima celula para a nova
    j in_retorno
inicializacao:
    move $s0, $v0 # Apontar o comeco da lista para a nova celula
in_retorno:
    lw $ra, ($sp) # Recupera o endereco de retorno
    addi $sp, $sp, 4 # Libera um espaco na pilha
    jr $ra # Retorna para a main

consulta:
    beqz $s0, listavazia # Verificacao de lista vazia
    move $t0, $s0 # Carrega o endereco da lista
consulta_loop:
    la $a0, Valor # Carrega o endereco da string
    li $v0, 4 # Codigo de impressao de string
    syscall # Imprime a string
    lw $a0, ($t0) # Carrega o valor da celula
    li $v0, 1 # Codigo de impressao de inteiro
    syscall # Imprime o inteiro
    la $a0, Newline # Carrega o endereco da string
    li $v0, 4 # Codigo de impressao de string
    syscall # Imprime a string
    lw $t0, 4($t0) # Carregar proximo endereco da lista
    bnez $t0, consulta_loop
    jr $ra # Retorna para a main

remocao:
    beqz $s0, listavazia # Verificacao de lista vazia
    subi $sp, $sp, 4 # Reserva um espaco na pilha
    sw $ra, ($sp) # Guarda o endereco de retorno na pilha
    jal obterultimo # Obtem a ultima celula da lista
    beqz $v1, rm_vazia # Se tiver apenas uma celula
    sw $zero, 4($v1) # Aponta a penultima celula para NULL
    j rm_retorno
rm_vazia:
    li $s0, 0 # Apontar comeco da lista para NULL
rm_retorno:
    lw $ra, ($sp) # Recupera o endereco de retorno
    addi $sp, $sp, 4 # Libera um espaco na pilha
    jr $ra # Retorna para a main

saida:
    li $v0, 10 # Codigo de saida do programa
    syscall # Sai do programa