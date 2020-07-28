.data
str: .space 30
ent1: .asciiz "Forneca a string S: "
ent2: .asciiz "Forneca o caractere C: "
ent3: .asciiz "\nForneca a posicao I: "
saida1: .asciiz "Posicao do primeiro caractere C encontrado a partir da posicao I na string S: "
saida2: .asciiz "Caractere nao encontrado!"

#Index
#$s0 --> caractere C
#$s1 --> posicao I
#$s2 --> tamanho da string S
#$s3 --> posicao na string S do primeiro caractere C encontrado a partir da posicao I

.text
main:
	la $a0, ent1
	la $a1, str
	jal lerString
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, ent2
	syscall
	
	li $v0, 12		#Codgio para leitura de caractere
	syscall
	move $s0, $v0
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, ent3
	syscall
	
	la $v0, 5		#Codigo para leitura de inteiro
	syscall
	move $s1, $v0
	
	la $a0, str		#Retorna o tamanho de uma string
	jal verificarTamanho
	move $s2, $v0
	
	la $a0, str
	move $a1, $s2
	move $a2, $s0
	move $a3, $s1
	jal charPosicStr	#Retorna a posicao na string S do primeiro caractere C encontrado a partir da posicao I
	move $s3, $v0
	blt $s3, 0, nFind	#Caso nao encontre o caractere, pula para notFind
	
	la $v0, 4		#Codigo para impressao de string
	la $a0, saida1
	syscall
	
	la $v0, 1		#Codigo para impressao de inteiro
	move $a0, $s3
	syscall
	
	j exit
	
nFind:	la $v0, 4		#Codigo para impressao de string
	la $a0, saida2
	syscall
	
exit:	li $v0, 10		#Codigo para finalizacao do programa
	syscall

lerString:
	li $v0, 4	#Codigo para impressao de string
	syscall
	
	li $v0, 8	#Codigo para leitura de string
	move $a0, $a1
	li $a1, 30
	syscall
	move $v0, $a2
	
	jr $ra

verificarTamanho:
	move $t1, $a0		#Move o endereco base da string para $t1
	la $t0, 0		#Reseta o contador $t0
	
loop1:	lb $t2, ($t1)		#Salva o conteudo armazenado no endereco de $t1 em $t2
	beq $t2, $zero, break1	#Pula para break1 se for igual
	beq $t2, 10, p		#Ignora a quebra de linha (\n)
	addi $t0, $t0, 1	#Incrementa o contador
p:	addi $t1, $t1, 1	#Percorre uma posicao na string
	j loop1			#Pula para loop1
	
break1:	sub $v0, $t0, 1		#Decrementa 1 do contador

	jr $ra			#Retorna para onde a funcao foi chamada

charPosicStr:
	move $t0, $a0		#Passa o endereco base da string para $t0
	add $t0, $t0, $a3	#Armazena o endereco da posicao I da string S em $t0
	move $t1, $a3		#Contador comeca na posicao I
	
loop:	lb $t2, ($t0)		#Armazena em $t2 o caractere contido no endereco salvo em $t0
	beq $t2, $a2, equal	#Se o caractere na string S for igual ao caractere C, retorna a posicao de C
	addi $t0, $t0, 1	#Incrementa o endereco da string S
	addi $t1, $t1, 1	#Incrementa o contador
	ble $t1, $a1, loop	#Repete enquanto nao percorrer toda string S
	
	li $v0, -1		#Retorna -1 caso nao encontre o caractere
	jr $ra
	
equal:	move $v0, $t1		#Retorna a posicao do caractere encontrado
	jr $ra
