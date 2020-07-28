.data
entradaTamanho: .asciiz "Insira o numero de linhas e colunas da matriz: "
entrada: .asciiz "Insirira o elemento["
entrada1: .asciiz "]["
entrada2: .asciiz "]:"

.text
#$s0.....tamanho de linhas e colunas da matriz (matriz quadrada)

main:
	jal proc_leit

	j exit

indice:
	

proc_leit:
	la $a0,	entradaTamanho
	li $v0, 4
	syscall
	
	li $v0, 5		#Leitura do tamanho N da matriz
	syscall
	move $s0, $v0
	
	move $t0, $s0		#Prepara o tamanho para a alocação dinamica
	mul $t0, $t0, $t0
	mul $t0, $t0, 4
	
	move $a0, $t0		#Aloca a matriz dinamicamente e salva o endereço em $s1
	li $v0, 9
	syscall
	move $s1, $v0
	
	move $t0, $s1		#Endereço base da matriz para $t0 (será incrementado)
	li $t1, 0		#i = 0
	li $t2, 0		#j = 0
	li $t3, 0		#Contador
	mul $t4, $s0, $s0	#Tamanho da matriz
	
lLoop:	la $a0, entrada		#Impressão da string de entrada
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, entrada1
	li $v0, 4
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	la $a0, entrada2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, ($t0)
	addi $t0, $t0, 4
	addi $t3, $t3, 1
	
	blt $t3, $t4, lLoop
	
	jr $ra
	
exit:
	li $v0, 10
	syscall