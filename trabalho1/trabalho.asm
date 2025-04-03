.data
.align 0
buffer: 	.space 32 # buffer para armazenar a entrada (até 31 caracteres + null)
erro:   	.asciz "algo inesperado ocorreu. programa encerrando\n"
operador:   	.byte 0 # variavel que armazena o operador (ah é nada)
resultado: 	.float 0.0 # variavel que armazena o resultado (ah é nada)
espera_num:     .word 1 # flag: 0 = espera operador, 1 = espera numero

.text
.align 2

le_input:
	li a7, 8 # serviço de leitura (leio como string)
    	la a0, buffer # endereço do buffer
    	li a1, 32 # tamanho máximo da leitura
    	ecall
    	
analisa_input:
	la a1, buffer
	lb t0, 0(a1) # carrega o primeiro caractere da entrada
	
	# verifica se é um numero
	li t1, '0'
	li t2, '9'
    	blt t0, t1, nao_numero # se t0 < t1, nao é um numero (aí tome branch)
    	bgt t0, t2, nao_numero # se t0 > t2 tambem tome branch
    	j eh_numero # caso esteja ali no intervalo 
    	
nao_numero:
	# verifica se é um operador. testo todos os operadores possiveis colocando em t1 e comparando com o conteúdo de t0 (entrada)
	li t1, '+'
	beq t0, t1, soma
	li t1, '-'
	beq t0, t1, subtrai
	li t1, '*'
	beq t0, t1, multiplica
	li t1, '/'
	beq t0, t1, divide
	
	# verifica se é f (finalizar) ou u (undo). coloca em t1 e compara com t0 (a entrada)
	li t1, 'f'
	beq t0, t1, finalizar
	li t1, 'u'
	beq t0, t1, undo

	j saida_de_erro # caso tenha chegado ate aqui a entrada nao é valida. vou para uma saída de erro

eh_numero:
	jal atoi
	fcvt.s.w fa0, a0 # converte inteiro pra float (sim, esse bagulho feio é pra fazer isso). a0 volta armazenando o inteiro que converti em atoi



soma:





subtrai:





multiplica:





divide:






undo:






atoi:
	la a1, buffer # endereça a entrada
	li a0, 0 # acumulador
	li t3, 10 # base decimal
	li t4, 1 # flag para sinal. caso sem sinal, t4 == 1. caso negativo, t4 == -1
	
	# verificando sinal
	lb t0, 0(a1) # le primeiro caractere
	li t1, '-' # usado para comparação
	bne t0, t1, atoi_loop # caso nao seja negativo, vai para a conversão
	li t4, -1 # caso seja negativo, guardo na flag
	addi a1,a1, 1 # avanço na string
	
atoi_loop:
	lb t0, 0(a1) # cacrrega o byte atual
	beqz t0, atoi_fim # caso o byte lido seja null, termina
	
	# validação de digito
	li t5, '0' # usando para comparação em casos de erro (e ali embaixo para colocar certo com base em ascii)
	li t6, '9' # mesmo de cima
	blt t1, t5, atoi_fim # caso nao seja digito valido, pulo pro fim
	bgt t1, t6, atoi_fim # mesmo de cima

	sub t0, t0, t5 # conversão para ascii, t0 = t0 - '0'
	
	# aqui to realmente guardando do jeito certo (em decimal) aquilo que eu converti
	mul a0, a0, t3 # a0 = a0 * 10
	add a0, a0, t0 # a0 = a0 + t0 
	
	addi a1, a1, 1
	j atoi_loop
	
atoi_fim:
	mul a0, a0, t4 # aplico o sinal que peguei la no começo
	jr ra # sai da função





finalizar: 
	# só encerra o programa, sem segredo
	li a7, 10
	ecall




saida_de_erro: 
	# imprime minha mensagem de erro e pulo pro finalizar (fecha o programa)
	li a7, 4
	la a0, erro
	ecall
	
	j finalizar
	





