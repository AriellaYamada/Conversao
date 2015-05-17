#Ariella Yamada Brambila 8937034
#Nathalia Bindilatti Felippe 8937441


.data
.align 0

strBaseIn : .asciiz "\nDigite a base do numero a ser inserido[B, D, H, O] ou 'S' para sair: "
strNum : .asciiz "\nDigite o numero: "
strBaseOut : .asciiz "\nDigite a base do numero de saida[B, D, H, O]: "
strEnter : .asciiz "\n"
strBin : .asciiz "0b"
strOctal : .asciiz "0o"
strHex : .asciiz "0x"
strInvalid : .asciiz "\nEntrada Invalida, verifique a base selecionada.\n"

.text

Inicio:

#printa a string strBaseIn
li $v0, 4	#print string
la $a0, strBaseIn
syscall

#le o char da base de entrada
li $v0, 12	#read char
syscall
add $s0, $zero, $v0	#armazena o char lido em $s0

#printa a string strNum
li $v0, 4	#print string
la $a0, strNum
syscall


CompareIn:

li $t3, 'B'	#carrega letra pra comparacao
beq $t3 $s0, BIn

li $t3, 'D'
beq $t3, $s0, DIn

li $t3, 'H' 
beq $t3, $s0, HIn

li $t3, 'O'
beq $t3, $s0, OIn

li $t3, 'S'
beq $t3, $s0, End

#j ErrorMessage

BIn:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0 #Inicializa resultado final
	li $t4, 2 #base
	
	li $t3, 1 #Maior algarismo possivel em binario
	li $t5, 32 #Maior nymero de dígitos possíveis
	 
	loopBIn:
		
		beqz $t5, loopBInEnd
		
		li $v0, 12	#read char
		syscall
		add $t0, $zero, $v0	#armazena o char lido em $t0
		
		li $t1, '\n'
		beq $t0, $t1, loopBInEnd
	
		mul $t2, $t2, $t4 	#multiplica o numero pela base
		
		subi $t0, $t0, '0'	#converte o caractere para decimal
		
		bltz $t0, ErrorMessage	#se valor digitado for menor que o minimo
		bgt $t0, $t3, ErrorMessage	#se valor digitado for maior que o maximo
		
		add $t2, $t2, $t0	#soma o caractere digitado
		
		subi $t5, $t5, 1
		
		j loopBIn
				
	loopBInEnd:
		
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		
		j Out

DIn:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0 #Inicializa resultado final
	li $t4, 10 #base
	
	li $t3, 9	#maior algarismo possivel em decimal
	 
	loopDIn:
		
		li $v0, 12	#read char
		syscall
		add $t0, $zero, $v0	#armazena o char lido em $t0
		
		li $t1, '\n'
		beq $t0, $t1, loopDInEnd
	
		mul $t2, $t2, $t4 	#multiplica o numero pela base
		
		subi $t0, $t0, '0'	#converte o caractere para decimal
		
		bltz $t0, ErrorMessage	#se valor digitado for menor que o minimo
		bgt $t0, $t3, ErrorMessage	#se valor digitado for maior que o maximo
		
		add $t2, $t2, $t0	#soma o caractere digitado
		
		j loopDIn
				
	loopDInEnd:
		
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		
		j Out

HIn:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0 #Inicializa resultado final
	li $t4, 16 #base
	li $t5, 8
	 
	loopHIn:
		
		beqz $t5, loopHInEnd
		
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
		
			li $t3, 9	#maior algarismo possivel ate 9 em hexadecimal
			
			subi $t0, $t0, '0'	#converte o caractere para decimal
			
			bltz $t0, ErrorMessage	#se valor digitado for menor que o minimo
			bgt $t0, $t3, ErrorMessage	#se valor digitado for maior que o maximo
			
			add $t2, $t2, $t0	#soma o caractere lido
			
			subi $t5, $t5, 1
			
			j loopHIn
		
		loopHInaf:
			
			li $t3, 5	#maior algarismo possivel ate f em hexadecimal (5 = f)
			
			subi $t0, $t0, 'a'	#converte o caractere para decimal (valor de 0 a 5)
			
			bltz $t0, ErrorMessage	#se valor digitado for menor que o minimo
			bgt $t0, $t3, ErrorMessage	#se valor digitado for maior que o maximo
			
			addi $t0, $t0, 10	#soma 10 (valor de 10 a 15)
			add $t2, $t2, $t0	#soma o caractere lido
			
			subi $t5, $t5, 1
			
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
	
	li $t3, 7	#maior algarismo possivel em octal
	li $t5, 11
	 
	loopOIn:
		
		beqz $t5, loopOInEnd
		
		li $v0, 12	#read char
		syscall
		add $t0, $zero, $v0	#armazena o char lido em $t0
		
		li $t1, '\n'
		beq $t0, $t1, loopOInEnd
	
		mul $t2, $t2, $t4 	#multiplica o numero pela base
		
		
		subi $t0, $t0, '0'	#converte o caractere para decimal
		bltz $t0, ErrorMessage	#se valor digitado for menor que o minimo
		bgt $t0, $t3, ErrorMessage	#se valor digitado for maior que o maximo
		add $t2, $t2, $t0	#soma o caractere lido
			
		subi $t5, $t5, 1
		
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
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	move $a0, $s1	#carrega o numero
	li $a1, 2	#carrega a base
	jal CountDig	#retorna o numero de digitos em $s2
	
	#aloca espaco na memoria para a string
	li $v0, 9	#sbrk
	add $a0, $zero, $s2	#tamanho
	syscall
	
	move $s3, $v0	#endereco da memoria alocada
	add $s3, $s3, $s2	#soma o endereco com o tamanho da string
	
	li $t0, '\0'
	sb $t0, ($s3)
	
		loopBOut:
			
			beqz $s1, loopBOutEnd	#se o numero for zero
			
			subi $s3, $s3, 1	#decrementa o valor do endereco da string
			
			andi $t0, $s1, 1	# num mod 2
			
			addi $t0, $t0, '0'	#transforma em char
			sb $t0, ($s3)	#armazena o digito no final da string
			
			sra $s1, $s1, 1 	#divide o numero por 2
			
			j loopBOut
			
loopBOutEnd:
	
	li $v0, 4
	la $a0, strBin
	syscall

	move $a1, $s3	#move a string para $a1
	jal printStr
	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	j Inicio	

DOut:

	li $v0, 36	#print decimal em decimal
	move $a0, $s1
	syscall
	
	j Inicio	

HOut:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t2, 0	#valor inicial
	li $t4, 1	#aux
	li $t5, 10	#base
	

		loopHOut:
			
			beqz $s1, loopHOutEnd	#se o numero for zero
			
			andi $t3, $s1, 15	# num mod 15
			
			mul $t3, $t3, $t4	#multiplica o mod pela base
			
			mul $t4, $t4, $t5	#multiplica pela base para mudar a casa decimal

			add $t2, $t2, $t3	#adiciona o mod no numero final
			
			sra $s1, $s1, 4 	#divide o numero por 16
			
			j loopHOut
			
	loopHOutEnd:	
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
	
		move $s1, $t2	#carrega o resultado em octal para $s1
	
		li $v0, 4
		la $a0, strHex
		syscall
	
		j DOut	

OOut:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	move $a0, $s1	#carrega o numero
	li $a1, 8	#carrega a base
	jal CountDig	#retorna o numero de digitos em $s2
	
	#aloca espaco na memoria para a string
	li $v0, 9	#sbrk
	add $a0, $zero, $s2	#tamanho
	syscall
	
	move $s3, $v0	#endereco da memoria alocada
	add $s3, $s3, $s2	#soma o endereco com o tamanho da string
	
	li $t0, '\0'
	sb $t0, ($s3)
	
		loopOOut:
			
			beqz $s1, loopOOutEnd	#se o numero for zero
			
			subi $s3, $s3, 1	#decrementa o valor do endereco da string
			
			andi $t0, $s1, 7	# num mod 7
			
			addi $t0, $t0, '0'	#transforma em char
			sb $t0, ($s3)	#armazena o digito no final da string
			
			sra $s1, $s1, 3 	#divide o numero por 8
			
			j loopOOut
			
loopOOutEnd:
	
	move $s1, $t2	#carrega o resultado em octal para $s1
	
	li $v0, 4
	la $a0, strOctal
	syscall

	move $a1, $s3	#move a string para $a1
	jal printStr
	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	j Inicio
	
End:

li $v0, 10
syscall		#termina programa

ErrorMessage:
	
	#print strInvalid
	li $v0, 4	#print string
	la $a0, strInvalid
	syscall
	
	j CompareIn
	
CountDig:

	#recebe o numero em $a0 e a base em $a1
	#retorna o numero de digitos em $s2

	addi $sp, $sp, -12
	sw $a1, 0($sp)
	sw $a0, 4($sp)
	sw $ra, 8($sp)
	
	move $t0, $a0	#copia o valor entrado
	move $t1, $a1	#copia o valor da base
	li $s2, 0	#inicializa o contador de digito
	
	loopCountDig:
		beqz $t0, loopCountDigEnd
		
		div $t0, $t0, $t1	#divide o numero pela base
		addi $s2, $s2, 1	#incrementa contador
		
		j loopCountDig
		
		loopCountDigEnd:
	
			addi $s2, $s2, 1	#espaco para o \0 da string
			lw $ra, 8($sp)
			lw $a0, 4($sp)
			lw $a1, 0($sp)
			addi $sp, $sp, 12
	
			jr $ra

printStr:

	addi $sp, $sp, -12
	sw $a1, 0($sp)
	sw $a0, 4($sp)
	sw $ra, 8($sp)

	li $t0, '\0'
	
		loopPrintStr:
			lb $t1, ($s3)
			
			beq $t1, $t0 loopPrintStrEnd
			
			li $v0, 11	#print char
			move $a0, $t1
			syscall
			
			addi $s3, $s3, 1	#incrementa a posicao de memoria
			
			j loopPrintStr
			
			loopPrintStrEnd:
				
				lw $ra, 8($sp)
				lw $a0, 4($sp)
				lw $a1, 0($sp)
				addi $sp, $sp, 12
	
				jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
