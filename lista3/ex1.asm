main: li $t0, 0		#contador i
      li $t1, 0		#soma temporaria
      li $s0, 0		#soma final
      
loop: beq $t0, 20, exit		#pula para "exit" se o contador for igual a 20
      addi $t0, $t0, 1		#acrescenta o contador
      mul $t1, $t0, 4		#multiplica o contador por 4 e escreve na soma temporaria
      addi $t1, $t1, 2		#soma 2 e escreve na soma temporaria
      add $s0, $s0, $t1		#soma a soma temporaria com a soma final
      j loop			#jump para o loop
      
exit: li $v0, 1		#prepara o sistema para imprimir integer
      move $a0, $s0	#copia o conteudo de $s0 para $a0
      syscall		#chama o sistema