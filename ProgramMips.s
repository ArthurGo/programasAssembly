	.data
mensagem_ini:	.asciiz "OlA USUARIO! :D\n"
pergunta:	.asciiz "Informe para mim um numero inteiro: \n"
mensagemFinal_s:.asciiz "O numero inserido e primo !! :D\n"
mensagemFinal_n:.asciiz "O numero inserido nao e primo :'(\n "
num:		.space 4

	.text
	# imprimindo mensagem inicial
main:	li $v0, 4			#carrega 4 no 'v0'
	la $a0, mensagem_ini		#imprime na tela a mensagem inicial
	syscall				#chamada do sistema 
	
	add $v0,$zero, $zero		#zero o $v0
  #imprimindo pergunta			
	li $v0, 4			#carrega 4 no 'v0'
	la $a0, pergunta		#imprime na tela a mensagem inicial
	syscall				#chamada do sistema

  #lendo inteiro
	li $v0, 5			#carrega 5 no 'v0'
	syscall
  
  #salvando na variavel	
	sw $v0, num($zero)		#salvando o numero inserido na variavel 'num'

	add $s2, $zero, $zero		#zerando valor do s2

	lw $s0, num($zero)		#carrega num para s0
	addi $t0, $zero, 1		#adiciona 1 no $t0	
	addi $t3, $zero, 2		#adiciona 2 na variavel pra controlar o if
	
for:	sle $t1, $t0, $s0		#verficando se o contador é menor que o valor inserido
	beq $t1, $zero, fim_for		#se nao for menor que o valor, faz o salto

if:	rem $t2, $s0, $t0		#faz divisao de $s0 por $t0 e armazena o resto da divisao
	bne $t2, $zero, j_for		#verifica se o resto da divisao deu 0
	addi $s2, $s2, 1		#se sim, adiciona 1 no contador dos divisores
	
j_for:	addi $t0, $t0, 1		#adiciona +1 no contador do for
	j for


fim_for:bne $s2, $t3, respNao		#verifica se existem apenas dois divisores para o num			  
  #imprimindo mensagem se for primo
	li $v0,4
	la $a0, mensagemFinal_s
	syscall
	j finalProg

  #imprimindo mensagem se nao for primo
respNao:li $v0,4
	la $a0, mensagemFinal_n
	syscall	
	
finalProg:jr $ra			# retorno da funcao
