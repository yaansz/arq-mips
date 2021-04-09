.data
	input: .word 0
	result: .word 0

	space: .asciiz " "

.text
	# Chamando a main
	j main
	
	#############################
	# Funcoes
	Fib:
		# move
		move $s0, $a0

		# Defininido fib1 e fib2
		addi $t1, $zero, 0
		addi $t2, $zero, 1

		# Printando o 0
			li $v0, 1
			move $a0, $t1
			syscall

			# Space
			li $v0, 4
			la $a0, space
			syscall

		# verificar se posso entrar no for
		blt $s0, 2, EndFib   
		
		# i = 3
		addi $t4, $zero, 2
		
		Loop:
			add $t3, $t1, $t2
			move $t1, $t2
			move $t2, $t3
			
			# i = i + 1
			addi, $t4, $t4, 1

			# Printando os valores
				li $v0, 1
				move $a0, $t1
				syscall

				# Space
				li $v0, 4
				la $a0, space
				syscall

			ble $t4, $s0, Loop
		EndFib:
	
	# Return
	jr  $ra
	
	#############################
	
	main:
		# Input
		li $v0, 5 # code to get integer input
		syscall
		
		# Copiando v0 para input 
		sw $v0, input
		
		# Copiando input para a0
		lw $a0, input
		# Chamando fun��o
		jal Fib
	
	# Fechar o programa
	li $v0, 10
	syscall
	