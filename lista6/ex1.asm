.data
str: .space 25
ent1: .asciiz "Insira a palavra: "
saida0: .asciiz "Nao e Palindromo!"
saida1: .asciiz "E Palindromo!"

.text
main:
	la $a0, ent1			#Carrega o parametro com a mensagem
	la $a1, str			#Carrega o parametro com o endereco base da string
	jal lerString			#Le uma string
	
	la $a0, str			#Carrega o parametro com o endereco base da string
	jal verificarTamanho		#Verifica o tamanho de uma string
	move $s0, $v0			#Salva o retorno da função em $s0
	
	la $a0, str 			#Carrega o parametro com o endereco base da string
	move $a1, $s0			#Carrega o parametro com o numero de posicoes da string
	jal verificarPalindromo		#Verifica se uma string e um Palindromo
	move $s1, $v0			#Armazena o retorno da funcao em $s1
	
	li $v0, 4			#Codigo para impressao de string
	beq $s1, 1, print1		#Pula para print0 e imprime que nao e Palindromo
	la $a0, saida0		#Passa o endereco da string saida0 para o parametro
	syscall
	j final
	
print1:	la $a0, saida1		#Passa o endereco da string saida1 para o parametro
	syscall
	
final:	jal exit			#Termina a execucao do programa
	
lerString:
	li $v0, 4	#Codigo para a impressao de string
	syscall
	move $a0, $a1	#Passa o endereco da string para o parametro
	li $a1, 25	#Carrega o parametro com o numero de caracteres a serem lidos
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
	
verificarPalindromo:
	move $t0, $a0		#Passa o endereco base da string para $t0
	move $t1, $a1		#Passa o tamanho da string para $t1
	add $t3, $t0, $t1	#Pega o endereco do ultimo caracter da string
	
loop2:	lb $t5, ($t0)		#Armazena em $t5 o conteudo contido no endereco $t0
	lb $t6, ($t3)		#Armazena em $t6 o conteudo contido no endereco $t4
	addi $t0, $t0, 1	#Incrementa 1 na posicao da string
	subi $t3, $t3, 1	#Deprementa 1 na posicao da stirng
	
	bne $t5, $t6, nPalin	#Pula para nPalin caso os caracteres sejam diferentes
	blt $t0, $t3, loop2	#Pula para loop2 enquanto $t1 for maior que $t0
	
	li $v0, 1		#Retorna 1 se for Palindromo
	jr $ra
	
nPalin:	li $v0, 0		#Retorna 0 se nao for Palindromo
	jr $ra
	
exit:
	li $v0, 10	#Codigo para finalizacao do programa
	syscall
