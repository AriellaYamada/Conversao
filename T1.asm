.data
.align 0

strTipoIn : .asciiz "Digite a base do numero a ser inserido[B, D, H, O]: "
strNum : .asciiz "\nDigite o numero: "
strTipoOut : .asciiz "\nDigite a base do numero de saida[B, D, H, O]: "

.text

li $v0, 4	#print string
la $a0, strTipoIn
syscall

li $v0, 12	#read char
syscall

add $t0, $zero, $v0	#armazena o char lido em $t0

li $t3, 'B'	#carrega letra pra comparacao



#li $v0, 11	#print char
#move $a0, $t3
#syscall

li $v0, 4	#print string
la $a0, strNum
syscall

add $t1, $zero, $v0	#armazena numero lido






li $v0, 4	#print string
la $a0, strTipoOut
syscall



li $v0, 10
syscall		#termina programa
