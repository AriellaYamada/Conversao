.data
.align 0

strBaseIn : .asciiz "Digite a base do numero a ser inserido[B, D, H, O]: "
strNum : .asciiz "\nDigite o numero: "
strBaseOut : .asciiz "\nDigite a base do numero de saida[B, D, H, O]: "
strNumero : .asciiz
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
#beq $t3, $t0, HIn

li $t3, 'O'
#beq $t3, $t0, OIn

BIn:

	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0 #Inicializa resultdo final
	li $t4, 2 #base
	 
	loopBIn:
		
		li $v0, 12	#read char
		syscall
		add $t0, $zero, $v0	#armazena o char lido em $t0
		
		li $t1, '\n'
		beq $t0, $t1, loopBInEnd
	
		mul $t2, $t2, $t4 	#multiplica o numero pela base
		
		li $t1, '1'
		beq $t0, $t1,, loopBIn1 #se for 1 
		j loopBIn #se for 0
		
		
		loopBIn1:
		
			addi $t2, $t2, 1
			
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

	

#HIn:

#OIn:

Out:

#printa string strBaseOut
li $v0, 4	#print string
la $a0, strBaseOut
syscall

#le o char da base de saida
li $v0, 12	#read char
syscall
add $t0, $zero, $v0	#armazena o char lido em $t0

#comparacoes

li $t3, 'B'	#carrega letra pra comparacao
add $a1, $zero, $t1
beq $t0, $t3, BOut

li $t3, 'D'
beq $t3, $t0, DOut

li $t3, 'H' 
beq $t3, $t0, HOut

li $t3, 'O'
#beq $t3, $t0, OOut

BOut:

	li $v0, 35	#print decimal em binario
	move $a0, $t2
	syscall
	
	j End	

DOut:

	li $v0, 1	#print decima em decimal
	move $a0, $t2
	syscall
	
	j End	

HOut:
	li $v0, 34	#print decimal em hexa
	move $a0, $t2
	syscall
	
	j End	
	

End:

li $v0, 10
syscall		#termina programa
