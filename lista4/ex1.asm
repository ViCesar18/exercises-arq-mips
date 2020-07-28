.data
	input: .asciiz "Informe um numero: "
	output: .asciiz "\nSoma: "

.text

main:
	li $s0, 0		# Carrega soma para 0
	li $t0, 0		# Carrega contador para 0
	
	j readingLoop
	
	j exit
	
readingLoop:
	add $t0, $t0 1		# Contador ++
	
	li $v0, 4		# Código de impressão de string
	la $a0, input		# Carrega o endereço do argumento de entrada
	syscall			# Chamada para impressão de string
	
	li $v0, 5		# Lê inteiro do teclado e guarda em $v0
	syscall			# Chamada para leitura de inteiro
	add $s0, $s0 $v0	# Adiciona o valor lido para soma
	beq $t0, 10, display	# Se contador == 10 pula para display
	j readingLoop		# Senão pula para readingLoop
	

display:
	li $v0, 4		# Código de impressão de string
	la $a0, output		# Carrega o endereço do argumento de saída (soma)
	syscall
	
	li $v0, 1		# Código de impressão de inteiro
	move $a0, $s0		# Move soma para o argumento
	syscall
	
exit:
	li $v0, 10		# Código para finalização do programa
	syscall			# Finaliza o programa
