	.data
resultado:  .float 0.0 # guarda o resultado (como float!)     
operador:   .byte 0 # guarda o operador atual
msg_erro:   .asciz "Entrada inválida!\n"

	.text
	.globl main

main: 
    	# lê o primeiro numero na inicialização
    	li a7, 5 # serviço para ler int
    	ecall
    
    	fcvt.s.w fa0, a0 # converte int para float
    	fmv.s ft0, fa0 # ft0 == acumulador

loop_calculadora:
    	# lê o operador (ou comando 'u' ou 'f')
    	li a7, 12 # serviço para ler char
    	ecall
    	
    	addi t1, a0, 0
    	ecall # essa ecall a mais é para "eliminar" o \n que se digita depois do caracter. inclusive, por isso uso o t1, e nao o a0 diretamente
    
	# verifica se é comando
    	li t0, 'f'
    	beq t1, t0, finalizar
    	li t0, 'u'
    	beq t1, t0, undo
    
    	# verifica se é operador válido
    	li t0, '+'
    	beq t1, t0, operacao
    	li t0, '-'
    	beq t1, t0, operacao
    	li t0, '*'
    	beq t1, t0, operacao
    	li t0, '/'
    	beq t1, t0, operacao
   	 
	# caso nao tenha sido nada de cima, deu erro
   	j entrada_invalida
	
operacao:
	la t1, operador
    	sb a0, 0(t1) # armazena o operador em t2
    
    	# lê o proximo int
    	li a7, 5            
    	ecall
    	fcvt.s.w fa1, a0 # denovo, conversão para float. fa1 sempre pega o novo numero
    	
	# executa operação
	la t1, resultado
    	flw ft0, 0(t1) # carrega o acumulador. ft0 sempre recebe o resultado corrente (da ultima operação). flw == load word de float
    	la t1, operador
    	lb t0, 0(t1) # pega o operador de volta
    	
    	# decide a operação
    	li t1, '+'
    	beq t0, t1, soma
    	li t1, '-'
    	beq t0, t1, subtracao
    	li t1, '*'
    	beq t0, t1, multiplicacao
    	li t1, '/'
    	beq t0, t1, divisao

soma:
    	fadd.s ft0, ft0, fa1
    	j atualiza_resultado

subtracao:
    	fsub.s ft0, ft0, fa1
    	j atualiza_resultado

multiplicacao:
    	fmul.s ft0, ft0, fa1
    	j atualiza_resultado

divisao:
    	fdiv.s ft0, ft0, fa1
	
atualiza_resultado:
	la t1, resultado
    	fsw ft0, 0(t1) # coloca o resultado atual guardado (fsw == sw com float)
    	j loop_calculadora

undo:
	# aqui nos dá um jeito de implementar o undo com os ponteiros	
    	j loop_calculadora

entrada_invalida:
    	li a7, 4
    	la a0, msg_erro
    	ecall
    	j loop_calculadora

finalizar:
    	li a7, 10
    	ecall