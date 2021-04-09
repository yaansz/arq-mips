.data
	finalFatorial: .word 0
	inputNumber: .word 5
	
	msg: .asciiz "Oi \n" 

.text
	# Chamando a main
	j main
	
	##################################################
	
	# Funcoes
	Fatorial:
		# Preciso armazenar o ra e o s0 pois usarei essas vari�veis
		# Com isso preciso pedir 8 bytes pra stack
		subu $sp, $sp, 4 # stack pointer - 8 (Bytes)
	
		# Agora irei usar esses bytes para armazenar os valores
		sw $ra, 0($sp) # valor do ra
		
		# Irei considerar o caso base do retorno como 1
		li $v0, 1
		# Primeiramente, if input <= 1
		ble $a0, 1, EndFatorial # Caso verdadeiro o retorno ser� 1 e iremos finalizar
		
			# Se chegar aqui,  input > 1 ent�o input * fatorial(input - 1)
			subi $a0, $a0, 1 # input = input - 1
			
			# Recursividade
			jal Fatorial
			
			# input = input - 1 + 1
			addi $a0, $a0, 1 
			
			# Agora � a multiplica��o realmente acontecendo
			# Sendo v0 o resultado da fun��o anterior e s0 o parametro atual
			# input * Fatorial (input - 1)
			mul $v0, $a0, $v0 
	 	 
		EndFatorial:
			# Pra fechar a fun��o preciso recuperar os valores
			lw $ra, 0($sp)
		
			# Agora posso mover o stack pointer de volta para o original
			addu $sp, $sp, 4
		
			# Retornar :D
			jr $ra
		
	
	##################################################
			
	# Fun��o main
	main:
		# Leitura do integer 
		li $v0, 5
		syscall
		
		# Salvando em inputNumber
		sw $v0, inputNumber
		
		
		# Jogar o valor do inputNumber pro registrador de parametro
		lw $a0, inputNumber
		# Rodando a fun��o
		jal Fatorial
		# Salvando o resultado na fun��o no label finalFatorial
		sw $v0, finalFatorial
		
		# Printando o resultado
		li $v0, 1
		lw $a0, finalFatorial
		syscall
		
	
	# Fechar a main/programa
	li $v0, 10
	syscall
