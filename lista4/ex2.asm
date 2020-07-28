.data
Entrada: .asciiz "Insira um valor: "
Resultado: .asciiz "Maior Valor: "

.text
main: jal scan 			#Chama a função scan
      move $s0, $v0		#Salva o retorno em $s0
      jal scan
      move $s1, $v0		#Salva o retorno em $s1
      move $a0, $s0		#Primeiro parâmetro: $s0
      move $a1, $s1		#Segundo parâmetro: $s1
      jal bigger		#Chama a função verificarMaior
      move $a0, $v0		#Passa o retorno da função verificaMaior para um parâmetro
      jal print			#Chama a função de imprimir
      j exit			#Finaliza o programa
      

scan: la $a0, Entrada 		#Carrega a string
      li $v0, 4		      	#Código para impressão de string
      syscall
      li $v0, 5	     		#Código para leitura de inteiro
      syscall
      jr $ra	    		#Retorna $v0
      
print: move $t0, $a0 	 	#Move o parêmetro $a0 para $t0
       la $a0, Resultado	#Carrega a string
       li $v0, 4		#Código para impressão de string
       syscall
       move $a0, $t0		#Move o conteúdo de $t0 para o parâmetro $a0
       li $v0, 1		#Código para impressão de inteiro
       syscall
       jr $ra			#Retorna $v0
       
bigger: bgt $a0, $a1, returnA0	#Se $a0 é maior que $a0, pula pra returnA0
		move $v0, $a1		#Se não pular, salva $a1 em $v0
		jr $ra			#Retorna $v0
		
returnA0: move $v0, $a0			#Salva $a0 em $v0
	  jr $ra			#Retorna $v0
	  
exit: li $v0, 10			#Código para sair do programa
      syscall
