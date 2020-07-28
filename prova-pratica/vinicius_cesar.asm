.data
entrada: .asciiz "Entre com o n�mero de elementos: "
entrada1: .asciiz "Vet["
entrada2: .asciiz "]= "

saidaA: .asciiz "O numero de elementos maiores que a soma dos N elementos lidos e = "
saidaB: .asciiz "O numero de elementos impares e = "
saidaBAux: .asciiz "Nao ha elementos impares no vetor!\n"
saidaC: .asciiz "O produto da posicao do maior elemento par do vetor com a posicao do menos elemento impar do vetor e = "
saidaCImpar: .asciiz "Nao ha elementos impares no vetor!\n"
saidaCPar: .asciiz "Nao ha elementos pares no vetor!\n"
saidaD: .asciiz "Vetor ordenado de forma crescente:\n"

quebraLinha: .asciiz "\n"
espaco: .asciiz " "

.text

###FOI ADOTADO A PRIMEIRA POSI��O DO VETOR COMO 0###

#$s0 = tamanho do vetor
#$s1 = endere�o base do vetor
#$s2 = soma dos elementos do vetor
#$s3 = n�mero de elementos maiores que a soma de todos os elementos do vetor
#$s4 = n�mero de elementos �mpares no vetor
#$s5 = produto da posi��o do maior elemento par do vetor com a posi��o do menor elemento �mpar (-1 se n�o houver �mpares ou -2 se n�o houver pares)

main:	
	jal read

	move $a0, $s0
	move $a1, $s1
	jal sum
	move $s2, $v0
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal proc_maior_soma
	move $s3, $v0
	
	la $a0, saidaA
	li $v0, 4
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	la $a0, quebraLinha
	li $v0, 4
	syscall
	
	move $a0, $s0
	move $a1, $s1
	jal proc_num_impar
	move $s4, $v0
	
	la $a0, saidaB
	li $v0, 4
	syscall
	beqz $s4, nImpar
	move $a0, $s4
	li $v0, 1
	syscall
	j impar
	
nImpar:	la $a0, saidaBAux
	li $v0, 4
	syscall
	
impar:	la $a0, quebraLinha
	li $v0, 4
	syscall
	
	move $a0, $s0
	move $a1, $s1
	jal proc_prod_pos
	move $s5, $v0
	
	la $a0, saidaC
	li $v0, 4
	syscall
	beq $s5, -1, sImpar
	beq $s5, -2, sPar
	
	move $a0, $s5
	li $v0, 1
	syscall
	la $a0, quebraLinha
	li $v0, 4
	syscall
	j endPos
	
sImpar:	la $a0, saidaCImpar
	li $v0, 4
	syscall
	j endPos
	
sPar:	la $a0, saidaCPar
	li $v0, 4
	syscall

endPos:	move $a0, $s0
	move $a1, $s1
	jal proc_ord
	
	move $a0, $s0
	move $a1, $s1
	jal print
	
	j exit
	
read:
	la $a0, entrada
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	move $a0, $s0
	li $v0, 9
	syscall
	move $s1, $v0
	
	li $t0, 0
	move $t1, $s1
	
lRead:	la $a0, entrada1
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	la $a0, entrada2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	sw $v0, ($t1)
	
	addi $t0, $t0, 1
	addi $t1, $t1, 4
	blt $t0, $s0, lRead
	
	jr $ra
	
sum:
	move $t0, $a0
	move $t1, $a1
	li $t2, 0
	li $t4, 0
	
lSum:	lw $t3, ($t1)
	add $t4, $t4, $t3
	
	addi $t2, $t2, 1
	addi $t1, $t1, 4
	blt $t2, $t0, lSum
	
	move $v0, $t4
	jr $ra

proc_maior_soma:
	move $t0, $a0
	move $t1, $a1
	li $t2, 0
	li $t3, 0

lMaior:	lw $t4, ($t1)
	ble $t4, $a2, menor
	addi $t3, $t3, 1

menor:	addi $t2, $t2, 1
	addi $t1, $t1, 4
	blt $t2, $t0, lMaior
	
	move $v0, $t3
	jr $ra
	
proc_num_impar:
	move $t0, $a0
	move $t1, $a1
	li $t2, 0
	li $t3, 2
	li $t6, 0
	
lImpar:	lw $t4, ($t1)
	div $t4, $t3
	mfhi $t5
	beqz $t5, par
	addi $t6, $t6, 1
	
par:	addi $t2, $t2, 1
	addi $t1, $t1, 4
	blt $t2, $t0, lImpar
	
	move $v0, $t6
	jr $ra
	
proc_prod_pos:
	move $t0, $a0
	move $t1, $a1
	li $t2, 0	#contador
	li $t3, 0	#verifica��o (caso n�o exista n�meros �mpares, ser� 0)
	li $t4, 0	#verifica��o (caso n�o exista n�meros pares, ser� 0)
	li $t5, 2	#Constante 2
	
lImPa:	lw $t6, ($t1)
	div $t6, $t5
	mfhi $t7
	beqz $t7, ePar
	
	li $t3, 1	#Caso seja �mpar
	move $t9, $t6
	j endPar
	
ePar:	li $t4, 1	#Caso seja par
	move $t8, $t6
	
endPar:	addi $t2, $t2, 1
	addi $t1, $t1, 4
	blt $t2, $t0, lImPa

	beqz $t3, zImpar
	beqz $t4, zPar
	
	li $t2, 0 	#reseta o contador
	move $t1, $a1	#Recupera o endere�o base do vetor
	li $t3, 0	#posi��o do maior n�mero �mpar
	li $t4, 0	#posi��o do menor n�mero par
	
lProd:	lw $t6, ($t1)
	div $t6, $t5
	mfhi $t7
	beqz $t7, posPar
	
	bgt $t6, $t9, end	#Caso seja �mpar
	move $t3, $t2
	move $t9, $t6
	j end
	
posPar:	blt $t6, $t8, end	#Caso seja par
	move $t4, $t2
	move $t8, $t6

end:	addi $t2, $t2, 1
	addi $t1, $t1, 4
	blt $t2, $t0, lProd

	mul $v0, $t3, $t4
	jr $ra
	
zImpar:	li $v0, -1
	j endFun

zPar:	li $v0, -2
	
endFun:	jr $ra

print:	move $t0, $a0
	move $t1, $a1
	li $t2, 0
	
lPrint:	lw $a0, ($t1)
	li $v0, 1
	syscall
	la $a0, espaco
	li $v0, 4
	syscall
	
	addi $t2, $t2, 1
	addi $t1, $t1, 4
	blt $t2, $t0, lPrint
	
	la $a0, quebraLinha
	li $v0, 4
	syscall
	
	jr $ra
	
exit:
	li $v0, 10
	syscall
