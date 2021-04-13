.data
	spaceMsg: .asciiz " "
	newLine: .asciiz "\n"
	msgLen: .asciiz "Digite o tamanho do array: "
	
	arrayLen: .word 5
	array: .word 0
	
	

.text
	# Chamando a main
	j main
	
	##################################################
	
	
	# Funcoes
	# a0 - array
	# a1 - length
	Bubble:
		# Setando o valor final = n - 1
		subi $t0, $a1, 1
		
		first_for_bubble:
			# n > 0 ?
			ble $t0, $zero, first_for_bubble_exit
		
			# Setando aux = false
			addi $t1, $zero, 0	
			
			# for novamente
			
			addi $t5, $zero, 0
			
			second_for_bubble:
				
				# i < end ?
				bge $t5, $t0, end_second_for
				
				# if array[i] > array[ i + 1]
				sll $t6, $t5, 2 # i * bytes
				addi $t7, $t5, 1 # i + 1
				sll $t7, $t7, 2 # (i + 1) * bytes
				
				add $t6, $t6, $a0 # base + i * bytes
				add $t7, $t7, $a0 # base + (i + 1) * bytes
				
				# Carregamento
				lw $t2, 0($t6) 
				lw $t3, 0($t7)
				
				# if array[i] > array[i + 1]
				ble $t2, $t3, second_for_bubble_increase
					
					sw $t3 0($t6)
					sw $t2 0($t7)
					# aux = true
					addi $t1, $zero, 1	
				
				
				second_for_bubble_increase:
				
					# i = i + 1
					addi $t5, $t5, 1
				
					j second_for_bubble	
			
			end_second_for:
			
			# end = end - 1
			subi $t0, $t0, 1
			
			# aux == 1 ?
			beq $t1, 0, first_for_bubble_exit
			
			j first_for_bubble
			
		first_for_bubble_exit:
		
			jr $ra
		
	
	
	
	# a0 - array
	# a1 - length
	Print:
		# for int i = 0; i < n; i++
		addi $t0, $zero, 0
		
		# array
		addi $t4, $a0, 0
		
		# len
		lw $t1, arrayLen
		
		for_print:
			bge $t0, $t1, for_print_exit
			# aqui if $t0 less than $t1
			
			# $t0 = posicao
			# $s1 = array base
			sll $t3, $t0, 2 # i * bytes
			add $t3, $t3, $t4 # base + (position * bytes)
			
			# Printa o numero
			li $v0, 1
			lw $a0, 0($t3)
			syscall
			
			# Espaco
			li $v0, 4
			la $a0, spaceMsg
			syscall

			# i = i + 1
			addi $t0, $t0, 1
			
			j for_print
		
		for_print_exit:
			jr $ra
		
		# END_PRINT
		
	##################################################
			
	# Funcao main
	main:
		# print "Digite o tamanho..." 
		li $v0, 4
		la $a0, msgLen
		syscall
		
		# scanf
		li $v0, 5
		syscall
		
		# Saving
		sw $v0, arrayLen
		
		# input << 2 -> length * bytes
		sll $s0, $v0, 2
		
		# ALOCACAO DINAMICA
		move $a0, $s0 	# v0 = retorno de strlen
		li $v0, 9       # codigo para alocar memoria
		syscall
		
		# salvando o ponteiro
		move $s1, $v0
		sw $s1, array
		
		# for int i = 0; i < n; i++
		addi $t0, $zero, 0
		lw $t1, arrayLen
		
		for_random:
			bge $t0, $t1, for_random_exit
			# aqui if $t0 less than $t1
			
			li $v0, 42  # 42 eh o comando de chamada de sistema para gerar um inteiro randomico
			move $a1, $t1 # $a1 eh onde eh setado o limite superior
			syscall     #o numero gerado estara em $a0 
			
			# $t0 = posicao
			# $s1 = array base
			sll $t3, $t0, 2 # i * bytes
			add $t3, $t3, $s1 # base + (position * bytes)
			
			# Salvando
			sw $a0, 0($t3)
			
			# i = i + 1
			addi $t0, $t0, 1
			
			j for_random
		for_random_exit:
		
		# a0 - array base
		# a1 - array len
		move $a0, $s1
		move $a1, $t1
		jal Print

		move $a0, $s1
		move $a1, $t1
		jal Bubble
		
		# newLine
		li $v0, 4
		la $a0, newLine
		syscall
		
		move $a0, $s1
		move $a1, $t1
		jal Print	
		
	# Fechar a main/programa
	li $v0, 10
	syscall
