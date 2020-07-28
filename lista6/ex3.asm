.data
str: .space 100
str2: .space 100
min: .space 100
entr: .asciiz "Insira a frase: "
saida: .asciiz "Frase codificada: "

.text
main:
	la $a0, entr		#Carrega o parametro com a mensagem
	la $a1, str		#Carrega o parametro com o endereco base da string
	jal lerString		#Le uma string
	
	la $a0, str		#Passa para o parametro o endereco base da string de entrada
	jal verificarTamanho	#Verifica o tamanho da string
	move $s0, $v0		#Armazena o tamanho da string em $s0
	
	la $a0, str		#Passa para o parametro o endereco base da string de entrada
	la $a1, min		#Passa para o parametro o endereco base da string resultado
	move $a2, $s0		#Passa para o parametro o tamanho da string de entrada
	jal lowercase		#Deixa todas as letras da string minusculas
	
	la $a0, min		#Passa o endereco base da string de entrada formatada para o parametro
	la $a1, str2		#Passa o endereco base da string de saida para o parametro
	move $a2, $s0		#Passa o tamanho da string para o parametro
	jal cesar4		#Codifica uma string com a Cifra de Cesar com 4 posicoes
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, saida
	syscall
	
	li $v0, 4
	la $a0, str2
	syscall
	
	j exit			#Finaliza o programa

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
	
lowercase:
	move $t0, $a0		#Passa o endereco base da string de entrada para $t0
	move $t2, $a1		#Passa o endereco base da string resultado para $t2
	li $t4, 0		#Reseta o contador $t4
	
loop2:	lb $t1, ($t0)		#Armazena em $t1 o conteudo associado ao endereco $t0
	
	blt $t1, 65, nLetra	#Verifica se $t1 e uma letra minuscula
	bgt $t1, 90, nLetra
	
	addi $t1, $t1, 32	#Passa o caracter armazenado em $t1 para maiusculo (somente se $t1 for uma letra minuscula)
	
nLetra:	sb $t1, ($t2)		#Armazena o caracter da string de entrada na string de saida (modificado ou nao)
	addi $t0, $t0, 1	#Salva em $t0 o endereco da proxima posicao na string de entrada
	addi $t2, $t2, 1	#Salva em $t2 o endereco da proxima posicao na string de saida
	addi $t4, $t4, 1	#Incrementa o contador
	ble $t4, $a2, loop2	#Pula para loop2 enquanto o contador for menor que o tamanho da string
	
	jr $ra
	
cesar4:
	move $t0, $a0		#Armazena o endereco base da string de entrada formatada em $t0
	move $t1, $a1		#Armazena o endereco base da string de saida em $t1
	li $t4, 0		#Reseta o contador $t4
	
loop3:	lb $t3, ($t0)		#Armazena em $t3 o conteudo do endereco $t0
	
	ble $t3, 97, nUpper	#Só soma se for uma letra minuscula
	bge $t3, 122, nUpper
	
	blt $t3, 119, adc	#Se ultrapassar a letra 'z'
	subi $t3, $t3, 26
	
adc:	addi $t3, $t3, 4	#Avanca 4 letras no alfabeto

nUpper:	sb $t3, ($t1)		#Armazena o conteudo contido em $t3 no endereco contido em $t1
	addi $t0, $t0, 1	#Anda uma posicao na string de entrada tratada
	addi $t1, $t1, 1	#Anda uma posicao na string de saida
	addi $t4, $t4, 1	#Incrementa o contador
	
	ble $t4, $a2, loop3	#Loop enquanto o contador e menor que o tamanho da string
	
	jr $ra
	
exit:
	li $v0, 10	#Codigo para finalizacao do programa
	syscall
