.data
str: .space 100
str2: .space 100
ent1: .asciiz "Insira a frase: "
saida1: .asciiz "Frase com todos os caracteres maiusculos: "

.text
main:
	la $a0, ent1		#Carrega o parametro com a mensagem
	la $a1, str		#Carrega o parametro com o endereco base da string
	jal lerString		#Le uma string
	
	la $a0, str		#Passa para o parametro o endereco base da string de entrada
	jal verificarTamanho	#Verifica o tamanho da string
	move $s0, $v0		#Armazena o tamanho da string em $s0
	
	la $a0, str		#Passa o endereco base da string de entrada como parametro
	la $a1, str2		#Passa o endereco base da string resultado como parametro
	move $a2, $s0		#Passa o tamanho da string de entrada para o parametro
	jal uppercase		#Passa todas as letras da string para maiusculo
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, saida1		#Passa para o parametro o endereco da string saida1
	syscall
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, str2		#Passa para o parametro o endereco base da string de saida
	syscall
	
	jal exit		#Termina a execucao do programa
	
lerString:
	li $v0, 4	#Codigo para a impressao de string
	syscall
	move $a0, $a1	#Passa o endereco da string para o parametro
	li $a1, 100	#Carrega o parametro com o numero de caracteres a serem lidos
	li $v0, 8	#Codigo para leitura de string
	syscall
	
	jr $ra		#Retorna para onde a funcao foi chamada
	
verificarTamanho:
	move $t1, $a0		#Move o endereco base da string para $t1
	la $t0, 0		#Reseta o contador $t0
	
loop1:	lb $t2, ($t1)		#Salva o conteudo armazenado no endereco de $t1 em #t2
	beq $t2, $zero, break1	#Pula para break1 se for igual
	beq $t2, 10, p		#Ignora a quebra de linha (\n)
	addi $t0, $t0, 1	#Incrementa o contador
p:	addi $t1, $t1, 1	#Percorre uma posicao na string
	j loop1			#Pula para loop1
		
break1:	sub $v0, $t0, 1		#Decrementa 1 do contador
	jr $ra			#Retorna para onde a funcao foi chamada
	
uppercase:
	move $t0, $a0		#Passa o endereco base da string de entrada para $t0
	move $t2, $a1		#Passa o endereco base da string resultado para $t2
	li $t4, 0		#Reseta o contador $t4
	
loop2:	lb $t1, ($t0)		#Armazena em $t1 o conteudo associado ao endereco $t0
	
	blt $t1, 97, nLetra	#Verifica se $t1 e uma letra minuscula
	bgt $t1, 122, nLetra
	
	subi $t1, $t1, 32	#Passa o caracter armazenado em $t1 para maiusculo (somente se $t1 for uma letra minuscula)
	
nLetra:	sb $t1, ($t2)		#Armazena o caracter da string de entrada na string de saida (modificado ou nao)
	addi $t0, $t0, 1	#Salva em $t0 o endereco da proxima posicao na string de entrada
	addi $t2, $t2, 1	#Salva em $t2 o endereco da proxima posicao na string de saida
	addi $t4, $t4, 1	#Incrementa o contador
	ble $t4, $a2, loop2	#Pula para loop2 enquanto o contador for menor que o tamanho da string
	
	jr $ra

exit:
	li $v0, 10	#Codigo para finalizacao do programa
	syscall