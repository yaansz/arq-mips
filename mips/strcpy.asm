.data
	source: .asciiz "NULL"
	destination: .asciiz "NULL"
	
	inputText: .asciiz "Entre com a palavra que sera copiada: "
	newLine: .asciiz "\n"
	string_source: .asciiz "Source: "
	string_destination: .asciiz "Destination: "
	space: .asciiz " - "
	
.text
    # Chamando a main
    j main

    ########################

    # Funcoes
    # a0 vai ser o endereco base da string
    # "abc" = retorna 4 ('a' 'b' 'c' '\0')
    strlen:
        # Reseta o registro de retorno 
        addi $v0, $zero, 0
        addi $t5, $zero, 10 # 10 = \n
			
        loop_strlen:
        	# Convertendo o valor
        	# lb
			lb $t0, ($a0)
        		
			# i = i + 1
			addi $v0, $v0, 1
			
			# Ponteiro + 1
			addi $a0, $a0, 1
			
			# If !($a0 == $zero) goto loop_strlen
			bne $t0, $t5, loop_strlen
			
		# Retornando
	jr $ra		
	
	# Copia
	cpy:
		subiu $sp, $sp, 4
		sw $ra, 0($sp)
		
		# endereco da origem no s1
		move $s0, $a0
		
		# TAMANHO DA ENTRADA
		# a0 eh o endereco de origem
		jal strlen
		
		# ALOCACAO DINAMICA
		move $a0, $v0 	# v0 = retorno de strlen
		li $v0, 9       # codigo para alocar memoria
		syscall
		
		# endereco do destino no s1
		move $s1, $v0
		
		cpy_for:
			lb $t1, 0($s0)
			sb $t1, 0($s1)
			
			addi $s0, $s0, 1
			addi $s1, $s1, 1
			
			bne $t1, 0, cpy_for
				
	lw $ra 0($sp)
	addiu $sp $sp 4
	jr $ra
	
    main:
		# MENSAGEM DE ENTRADA
		li $v0, 4
		la $a0, inputText
		syscall

		# ENTRADA
		li $v0, 8 		# Codigo de String
		la $a0, source  # Lugar armazenado
		li $a1, 20 		# Tamanho Maximo
		syscall
		
		# cpy
		# a0 = endereco da string origem
		jal cpy
		move $s0, $v0
		
		# ORIGINAL		
		li $v0, 4
		la $a0, string_source
		syscall
		
		# ENDERECO
		li $v0, 1
		la $a0, source
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
		# STRING
		li $v0, 4
		la $a0, source
		syscall
		
		
		# Destino
		li $v0, 4
		la $a0, string_destination
		syscall
		
		# ENDERECO
		li $v0, 1
		move $a0, $s0 
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
		# STRING
		li $v0, 4
		move $a0, $s0 
		syscall
	
	# Fechar o programa
	li $v0, 10
	syscall
