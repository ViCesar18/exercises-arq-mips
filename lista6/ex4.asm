.data
str1: .space 30
str2: .space 30
strcat: .space 60
strinverse: .space 30
substr: .space 30
entA: .asciiz "1 - Ler uma string S1\n"
entB: .asciiz "2 - Imprimir o tamanho de S1\n"
entC: .asciiz "3 - Comparar S1 com uma string S2 fornecida pelo usuario\n"
entD: .asciiz "4 - Concatenar S1 com S2\n"
entE: .asciiz "5 - Imprimir S1 de forma reversa\n"
entF: .asciiz "6 - Contar quantas vezes o caractere aparece em S1\n"
entG: .asciiz "7 - Substituir a primeira ocorrencia do caractere C1 de S1 pelo caractere C2\n"
entH: .asciiz "8 - Verificar se uma string S2 e substring de S1\n"
entI: .asciiz "9 - Imprimir uma substring de S1 a partir de um dado caracter e do tamanho dessa substring\n"
sair: .asciiz "10 - Sair\n"
op: .asciiz "Selecione uma opcao: "
ent1: .asciiz "Insira S1: "
saida1: .asciiz "S1 inserida com sucesso!\n\n"
saida2: .asciiz "Tamanho de S1: "
ent3: .asciiz "Insira S2: "
saida31: .asciiz "S1 = S2\n\n"
saida32: .asciiz "S1 < S2\n\n"
saida33: .asciiz "S1 > S2\n\n"
saida4: .asciiz "Resultado da concatenacao: "
saida5: .asciiz "S1 Invertida: "
ent6: .asciiz "Insira o caractere: "
saida61: .asciiz "O caractere aparece "
saida62: .asciiz " em S1!\n\n"
ent71: .asciiz "Insiria C1: "
ent72: .asciiz "\nInsira C2: "
saida7: .asciiz "Caracteres trocados com sucesso!\nResultado: "
saida81: .asciiz "S2 e substring de S1\n\n"
saida82: .asciiz "S2 nao e substring de S1\n\n"
ent91: .asciiz "Forneca a posicao inicial da substring: "
ent92: .asciiz "Forneca o tamanho da substring: "
saida9: .asciiz "Substring: "
breakLine: .asciiz "\n"

#Index
#Opcao = $s0
#Tamanho do vetor = $s1
#Numero de caracteres = $s2
#Resultado da comparacao = $s3
#Caracter 1 = $s4
#Caracter 2 = $s5
#Numero de vezes que um caractere aparece em uma string = $s6
#Resultado da verificacao de substring = $s7

.text
main:
	li $v0, 4	#Impressao do menu
	la $a0, entA
	syscall
	la $a0, entB
	syscall
	la $a0, entC
	syscall
	la $a0, entD
	syscall
	la $a0, entE
	syscall
	la $a0, entF
	syscall
	la $a0, entG
	syscall
	la $a0, entH
	syscall
	la $a0, entI
	syscall
	la $a0, sair
	syscall
ver:	li $v0, 4
	la $a0, op
	syscall	
	
	li $v0, 5		#Codigo para leitura de inteiros
	syscall
	move $s0, $v0
	blt $s0, 1, ver		#Veririca se o numero esta entre 1 e 10
	bgt $s0, 10, ver
	
	beq $s0, 1, op1
	beq $s0, 2, op2
	beq $s0, 3, op3
	beq $s0, 4, op4
	beq $s0, 5, op5
	beq $s0, 6, op6
	beq $s0, 7, op7
	beq $s0, 8, op8
	beq $s0, 9, op9
	beq $s0, 10, op10
	
op1:	
	la $a0, ent1
	la $a1, str1
	jal lerString
	li $v0, 4		#Codigo para impressao de string
	la $a0, saida1
	syscall
	
	la $a0, str1		#Verifica o tamanho de S1
	jal verificarTamanho
	move $s1, $v0
	addi $s2, $s1, 1
	
	j main
	
op2:	
	li $v0, 4		#Codigo para impressao de string
	la $a0, saida2
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, breakLine
	syscall
	syscall
	
	j main
	
op3:
	la $a0, ent3
	la $a1, str2
	jal lerString		#Le S2
	
	la $a0, str2
	jal verificarTamanho	#Verifica o tamanho de S2
	move $a3, $v0
	
	la $a0, str1
	la $a1, str2
	move $a2, $s1
	jal strcmp		#Compara duas strings
	move $s3, $v0
	
	li $v0, 4		#Codigo para impressao de string
	beq $s3, 0, eCMP
	beq $s3, -1, lCMP
	beq $s3, 1, gCMP
	
eCMP:	la $a0, saida31
	j cmp

lCMP:	la $a0, saida32
	j cmp

gCMP:	la $a0, saida33

cmp:	syscall
	j main
	
op4:
	la $a0, ent3
	la $a1, str2
	jal lerString		#Le S2
	
	la $a0, str2
	jal verificarTamanho	#Verifica o tamanho de S2
	move $a3, $v0
	
	la $a0, str1
	la $a1, str2
	move $a2, $s1
	jal strconcat		#Concatena duas strings
	
	li $v0, 4		#Codigo para impressao de string
	
	la $a0, saida4
	syscall
	
	la $a0, strcat
	syscall
	
	la $a0, breakLine
	syscall
	
	la $a0, breakLine
	syscall

	j main

op5:
	la $a0, str1
	move $a1, $s1
	la $a2, strinverse
	jal inverterString	#Inverte uma string

	li $v0, 4		#Codigo de impressao de string
	la $a0, saida5
	syscall
	
	la $a0, strinverse
	syscall
	
	la $a0, breakLine
	syscall
	
	la $a0, breakLine
	syscall

	j main

op6:
	li $v0, 4		#Codigo para impressao de string
	la $a0, ent6
	syscall

	li $v0, 12		#Codigo para leitura de caractere
	syscall
	move $s4, $v0		#Armazena o caractere lido em $s4
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, breakLine
	syscall
	
	la $a0, str1
	move $a1, $s4
	move $a2, $s4
	jal verificarCaractere
	move $s6, $v0
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, saida61
	syscall
	
	li $v0, 1		#Codigo para impressao de inteiro
	move $a0, $s6
	syscall
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, saida62
	syscall

	j main

op7:
	li $v0, 4		#Codigo para impressao de string
	la $a0, ent71
	syscall

	li $v0, 12		#Codigo para leitura de caractere
	syscall
	move $s4, $v0		#Armazena o caractere lido em $s4
	
	li $v0, 4		#Codigo para impressao de strin
	la $a0, breakLine
	syscall
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, ent72
	syscall
	
	li $v0, 12		#Codigo para leitura de caractere
	syscall
	move $s5, $v0
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, breakLine
	syscall
	
	la $a0, str1
	move $a1, $s1
	move $a2, $s4
	move $a3, $s5
	jal trocarPrimeiraOcorrencia	#Troca a primeira ocorrencia do caractere C1 na string S1 pelo caractere C2

	li $v0, 4		#Codigo para impressao de string
	la $a0, saida7
	syscall
	
	la $a0, str1
	syscall
	
	la $a0, breakLine
	syscall
	
	la $a0, breakLine
	syscall

	j main
	
op8:
	la $a0, ent3
	la $a1, str2
	jal lerString		#Le S2
	
	la $a0, str2
	jal verificarTamanho	#Verifica o tamanho de S2
	move $a3, $v0
	
	la $a0, str1
	la $a1, str2
	move $a2, $s1
	jal verificarSubstring	#Verifica se uma string S2 e substring de S1
	move $s7, $v0
	
	li $v0, 4		#Codigo para impressao de string
	beq $s7, 0, nSub
	la $a0, saida81
	j jSub

nSub:	la $a0, saida82
jSub:	syscall

	j main

op9:
vSub1:	li $v0, 4		#Codigo para impressao de string
	la $a0, ent91
	syscall
	
	li $v0, 5		#Codigo para leitura de inteiro
	syscall
	move $k0, $v0		#Salva a posicao inicial da substring em $k0
	
	blt $k0, 0, vSub1	#Verifica se a posicao e menor que 0 ou maior que o tamanho maximo de S1. Saso seja, pede a leitura novamente
	bgt $k0, $s1, vSub1
	
	sub $t0, $s1, $k0	#Verifica o tamanho maximo da substring e salva em $t0
	
vSub2:	li $v0, 4		#Codigo para impressao de string
	la $a0, ent92
	syscall
	
	li $v0, 5		#Codigo para leitura de inteiro
	syscall
	move $k1, $v0		#Armazena o tamanho da substring em $k1
	
	blt $k1, 0, vSub2	#Verifica se o tamanho e menor que 0 ou maior que o tamanho maximo possivel. Caso seja, pede a leitura novamente
	bgt $k1, $t0, vSub2
	
	la $a0, str1
	la $a1, substr
	move $a2, $k0
	move $a3, $k1
	jal criarSubstring	#Cria uma substring de S1 a partir de uma dada posicao inicial e um dado tamanho
	
	li $v0, 4		#Codigo para impressao de string
	la $a0, saida9
	syscall
	
	la $a0, substr
	syscall
	
	la $a0, breakLine
	syscall
	
	la $a0, breakLine
	syscall

	j main
	
op10:
	li $v0, 10		#Codigo para finalizacao do programa
	syscall

lerString:
	li $v0, 4	#Codigo para impressao de string
	syscall
	
	li $v0, 8	#Codigo para leitura de string
	move $a0, $a1
	li $a1, 30
	syscall
	
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
	
strcmp:
	move $t0, $a0		#Passa para $t0 o endereco base de S1
	move $t1, $a1		#Passa para $t1 o endereco base de S2
	li $t5, 0		#Reseta o contador $t5
	
	blt $a2, $a3, b1	#Retorna -1 caso S1 seja menor que S2
	bgt $a2, $a3, b2	#Retorna 1 caso S1 seja maior que S2
	
lcmp:	lb $t3, ($t0)		#Armazena em $t3 o conteudo salvo no endereco $t0
	lb $t4, ($t1)		#Armazena em $t4 o conteudo salvo no endereco $t0
	addi $t0, $t0, 1	#Incrementa o endereco de S1
	addi $t1, $t1, 1	#Incrementa o endereco de S2
	addi $t5, $t5, 1	#Incrementa o contador
	bne $t3, $t4, nEqual	#Se os caracteres nao forem iguais, pula pro retorno
	ble $t5, $a3, lcmp	#Se os caracteres forem iguais, continua verificando
	li $v0, 0		#Se S1 == S2, retorna 0
	j brkcmp
	
nEqual:	blt $t3, $t4, b1	#Retorna -1 caso S1 seja menor que S2
	bgt $t3, $t4, b2	#Retorrna 1 caso S1 seja maior que S2
	
			
b1:	li $v0, -1
	j brkcmp
	
b2:	li $v0, 1
	
brkcmp:	jr $ra

strconcat:
	move $t0, $a0		#Passa o endereco base de S1 para $t0
	move $t1, $a1		#Passa o endereco base de S2 para $t1
	move $t2, $a2		#Passa o tamanho de S1 para $t2
	move $t3, $a3		#Passa o tamanho de S2 para $t3
	la $t4, strcat		#Carrega o endereco base da string concatenada em $t4
	li $t5, 0		#Reseta o contador $t5
	
lCatS1:	lb $t6, ($t0)		#Armazena em $t6 o caractere contido no endereco salvo por $t0
	sb $t6, ($t4)		#Armazena o caractere contido em $t6 no endereco salvo por $t4
	addi $t0, $t0, 1	#Incrementa o endereco de S1
	addi $t4, $t4, 1	#Incrementa o endereco da string concatenada
	addi $t5, $t5, 1	#Incrementa o contador
	ble $t5, $t2, lCatS1	#Repete ate percorrer toda S1
	
	li $t5, 0		#Reseta o contador
	
lCatS2:	lb $t6, ($t1)		#Armazena em $t6 o caractere contido no endereco salvo por $t1
	sb $t6, ($t4)		#Armazena o caractere contido em $t6 no endereco salvo por $t4
	addi $t1, $t1, 1	#Incrementa o endereco de S2
	addi $t4, $t4, 1	#Incrementa o endereco da string concatenada
	addi $t5, $t5, 1	#Incrementa o contador
	ble $t5, $t3, lCatS2	#Repere ate percorrer toda S2
	
	jr $ra			#Retorna para onde a funcao foi chamada
	
inverterString:
	move $t0, $a0		#Passa o endereco base de S1 para $t0
	move $t1, $a1		#Passa o tamanho de S1 para $t1
	move $t2, $a2		#Passa o endereco base da string inversa para $t2
	add $t0, $t0, $t1	#Armazena o endereco do ultimo caractere de S1 para $t0
	li $t3, 0		#Reseta o contador $t3
	
lInver:	lb $t4, ($t0)		#Armazena em $t4 o caractere contido no endereco salvo por $t0
	sb $t4, ($t2)		#Armazena o caractere contido em $t4 no endereco salvo por $t2
	subi $t0, $t0, 1	#Decrementa o endereco de S1
	addi $t2, $t2, 1	#Incrementa o endereco da string inversa
	addi $t3, $t3, 1	#Incrementa o contador
	ble $t3, $t1, lInver	#Repete ate percorrer toda S1
	
	jr $ra

verificarCaractere:
	move $t0, $a0		#Passa o endereco base de S1 para $t0
	move $t1, $a1		#Passa o tamanho de S1 para $t1
	li $t2, 0		#Reseta o contador $t2
	li $t3, 0		#Numero de vezes que o caractere aparece
	
cLoop:	lb $t4, ($t0)		#Armazena em $t4 o caractere contido no endereco salvo por $t0
	bne $a2, $t4, cNe	#Caso o caractere de S1 nao seja igual ao caractere lido do usuario, nao incrementa $t2
	addi $t3, $t3, 1	#Incrementa $t3 caso seja igual
cNe:	addi $t0, $t0, 1	#Incrementa o endereco de S1
	addi $t2, $t2, 1	#Incrementa o contador
	ble $t2, $t1, cLoop	#Repete ate percorrer toda S1
	
	move $v0, $t3
	jr $ra
	
trocarPrimeiraOcorrencia:
	move $t0, $a0		#Passa o endereco base de S1 para $t0
	move $t1, $a1		#Passa o tamanho de S1 para $t1
	li $t2, 0		#Reseta o contador $t2
	
pLoop:	lb $t4, ($t0)		#Armazena em $t4 o caractere contido no endereco salvo por $t0
	beq $a2, $t4, cEq	#Caso o caractere seja igual, sai do loop
	addi $t0, $t0, 1	#Incrementa o endereco de S1
	addi $t2, $t2, 1	#Incrementa o contador
	ble $t2, $t1, pLoop	#Repete ate percorrer toda S1
	j brk
	
cEq:	sb $a3, ($t0)		#Troca o caractere contido no endereco $t0 da string S1 pelo caractere contido em $a

brk:	jr $ra

verificarSubstring:
	move $t0, $a0		#Passa o endereco base de S1 para $t0
	move $t1, $a1		#Passa o endereco base de S2 para $t1
	move $t2, $a2		#Passa o tamanho de S1 para $t2
	move $t3, $a3		#Passa o tamanho de S2 para $t3
	li $t4, 0		#Reseta o contador $t4 (S1)
	li $t8, 0		#Reseta o contador $t8 (S2)
	li $t7, 0		#Reseta o registrador (aux)
	
sub1:	lb $t5, ($t0)		#Armazena em $t5 o caractere contido no endereco armazenado por $t0
	lb $t6, ($t1)		#Armazena em $t6 o caractere contido no endereco armazenado por $t1
	bne $t5, $t6, sub2	#Se forem caracteres diferentes, volta S1 para a ultima posicao salva ($t7) e reseta S2
	beq $t8, $a3, sub4	#Se percorrer toda S2, S2 esta completamente dentro de S1
	addi $t0, $t0, 1	#Incrementa o endereco de S1
	addi $t1, $t1, 1	#Incrementa o endereco de S2
	addi $t4, $t4, 1	#Incrementa o contador
	addi $t8, $t8, 1	#Incrementa o contador
	ble $t4, $t2, sub1	#Repete o precesso ate percorrer toda S1
	
sub2:	addi $t7, $t7, 1	#Avanca uma posicao salva
	move $t4, $t7		#Reseta o contador de S1 para esta posicao
	add $t0, $a0, $t7	#Armazena o endereco da posicao salva
	
	li $t8, 0		#Reseta o contador de S2
	move $t1, $a1		#Armazena o endereco da primeira posicao de S2 novamente em $t1
	
	ble $t7, $a2, sub1	#Repete o processo ate percorrer toda S1 e S2
	
	li $v0, 0
	j sub3
	
sub4:	li $v0, 1
	
sub3:	jr $ra
	
criarSubstring:
	move $t0, $a0		#Passa o endereco base de S1 para $t0
	move $t1, $a1		#Passa o endereco base da substring para $t1
	add $t0, $t0, $a2	#Armazena em $t0 o endereco da posicao inicial da substring
	li $t2, 0		#Reseta o contador
	
cSub1:	lb $t3, ($t0)		#Armazena em $t3 o caractere contido no endereco salvo por $t0
	sb $t3, ($t1)		#Armazena o caractere contido em $t3 no endereco salvo por $t1
	addi $t0, $t0, 1	#Incrementa o endereco de S1
	addi $t1, $t1, 1	#Incrementa o endereco da substring
	addi $t2, $t2, 1	#Incrementa o contador
	ble $t2, $a3, cSub1	#Repete enquanto o contador for menor que o tamanho da substring
	
	sb $zero, ($t1)		#Coloca o \0 no final da substring
	
	jr $ra
