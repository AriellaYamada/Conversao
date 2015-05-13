.data
.align 0

strBaseIn : .asciiz "Digite a base do numero a ser inserido[B, D, H, O]: "
strNum : .asciiz "\nDigite o numero: "
strBaseOut : .asciiz "Digite a base do numero de saida[B, D, H, O]: "
strEnter : .asciiz "\n"
strOctal : .asciiz "0o"

.text

#printa a string strBaseIn
li $v0, 4	#print string
la $a0, strBaseIn
syscall

#le o char da base de entrada
li $v0, 12	#read char
syscall
add $t0, $zero, $v0	#armazena o char lido em $t0

#li $v0, 11	#print char
#move $a0, $t3
#syscall

#printa a string strNum
li $v0, 4	#print string
la $a0, strNum
syscall


#comparacoes

li $t3, 'B'	#carrega letra pra comparacao
beq $t0, $t3, BIn

li $t3, 'D'
beq $t3, $t0, DIn

li $t3, 'H' 
beq $t3, $t0, HIn

li $t3, 'O'
beq $t3, $t0, OIn


BIn:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0 #Inicializa resultado final
	li $t4, 2 #base
	 
	loopBIn:
		
		li $v0, 12	#read char
		syscall
		add $t0, $zero, $v0	#armazena o char lido em $t0
		
		li $t1, '\n'
		beq $t0, $t1, loopBInEnd
	
		mul $t2, $t2, $t4 	#multiplica o numero pela base
		
		subi $t0, $t0, '0'	#converte o caractere para decimal
		add $t2, $t2, $t0	#soma o caractere digitado
		
		j loopBIn
				
	loopBInEnd:
		
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		
		j Out

DIn:
	#Le decimal
	li $v0, 5
	syscall
	
	#Armazena numero lido
	add $t2, $zero, $v0
	
	j Out

HIn:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0 #Inicializa resultado final
	li $t4, 16 #base
	 
	loopHIn:
		
		li $v0, 12	#read char
		syscall
		add $t0, $zero, $v0	#armazena o char lido em $t0
		
		li $t1, '\n'
		beq $t0, $t1, loopHInEnd
	
		mul $t2, $t2, $t4 	#multiplica o numero pela base
		
		
		subi $t1, $t0, 'a'	#resultado eh menor que zero, caso seja entre 0 e 9
		bltz $t1, loopHIn09 #se for de 0 a 9
		j loopHInaf #se for de A a F
		
		
		loopHIn09:
		
			subi $t0, $t0, '0'	#converte o caractere para decimal
			add $t2, $t2, $t0	#soma o caractere lido
			
			j loopHIn
		
		loopHInaf:
			
			subi $t0, $t0, '0'	#converte o caractere para decimal (valor de 0 a 5)
			addi $t0, $t0, 10	#soma 10 (valor de 10 a 15)
			add $t2, $t2, $t0	#soma o caractere lido
			
			j loopHIn
				
	loopHInEnd:
		
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		
		j Out

OIn:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0 #Inicializa resultado final
	li $t4, 8 #base
	 
	loopOIn:
		
		li $v0, 12	#read char
		syscall
		add $t0, $zero, $v0	#armazena o char lido em $t0
		
		li $t1, '\n'
		beq $t0, $t1, loopOInEnd
	
		mul $t2, $t2, $t4 	#multiplica o numero pela base
		
		
		subi $t0, $t0, '0'	#converte o caractere para decimal
		add $t2, $t2, $t0	#soma o caractere lido
			
		j loopOIn
		
				
	loopOInEnd:
		
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		
		j Out


Out:

move $s1, $t2	#move o numero lido para $s1

#printa string strBaseOut
li $v0, 4	#print string
la $a0, strBaseOut
syscall

#le o char da base de saida
li $v0, 12	#read char
syscall
add $t0, $zero, $v0	#armazena o char lido em $t0

#print quebra de linha
li $v0, 4
la $a0, strEnter
syscall

#comparacoes

li $t3, 'B'	#carrega letra pra comparacao
add $a1, $zero, $t1
beq $t0, $t3, BOut

li $t3, 'D'
beq $t3, $t0, DOut

li $t3, 'H' 
beq $t3, $t0, HOut

li $t3, 'O'
beq $t3, $t0, OOut



BOut:

	li $v0, 35	#print decimal em binario
	move $a0, $s1
	syscall
	
	j End	

DOut:

	li $v0, 1	#print decimal em decimal
	move $a0, $s1
	syscall
	
	j End	

HOut:
	li $v0, 34	#print decimal em hexadecimal
	move $a0, $s1
	syscall
	
	j End	

OOut:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0	#valor inicial
	li $t4, 1	#aux
	li $t5, 10	#base
	

		loopOOut:
			
			beqz $s1, loopOOutEnd	#se o numero for zero
			
			andi $t3, $s1, 7	# num mod 7
			
			mul $t3, $t3, $t4	#multiplica o mod pela base
			
			mul $t4, $t4, $t5	#multiplica pela base para mudar a casa decimal

			add $t2, $t2, $t3	#adiciona o mod no numero final
			
			sra $s1, $s1, 3 	#divide o numero por 8
			
			j loopOOut
			
loopOOutEnd:	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	move $s1, $t2	#carrega o resultado em octal para $s1
	
	li $v0, 4	#print string
	la $a0, strOctal
	syscall
	
	j DOut

End:

li $v0, 10
syscall		#termina programa
