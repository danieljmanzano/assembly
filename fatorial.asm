	.data
	.align 0
msg:    .asciz "resultado: "

	.text
	.align 2
	.globl main
main:
	addi a7, zero, 5 # 5 == leitura de int 
	ecall
	add s0, a0, zero  # guardo o número lido em s0
	addi s1, zero, 1 # s1 vai guardar meu resultado. ja inicializo ele com 1 (para casos que o número lido seja 0 ou 1)
	
	
	beq s0, zero, printa_resultado # se o número recebido (s0) for igual ao conteúdo de zero (que é zero né), pulo pra printar o resultado (beq == branch if equal)
	addi t0, zero, 1 # t0 vai ser meu contador mais pra frente. aqui uso pra ver se o número recebido foi 1
	beq s0, t0, printa_resultado # se s0 for igual a 1 (que acabei de colocar em t0), pulo pra printar o resultado também 
	
	
	addi t0, zero, 2 # coloco t0 (meu contador) como 2 para começar no loop aqui embaixo
loop:
	mul s1, s1, t0 # multiplica meu s1 pelo contador e guarda o resultado no próprio s1
	addi t0, t0, 1 # incrementa meu contador
	ble t0, s0, loop # se t0 <= s0, continuo no loop (ble == branch if less or equal). ou seja, enquanto o contador ainda não chegou no meu número de entrada, continuo no loop
	
	
printa_resultado:
	addi a7, zero, 4 # 4 == imprimir string
	la a0, msg # load adress da minha mensagem em a0 pra printar quando chamar o ecall
	ecall

	addi a7, zero, 1 # 1 == imprimir um inteiro
	add a0, zero, s1 # pego o resultado do fatorial (s1) e coloco em a0
	ecall
	
	addi a7, zero, 10 # algo que aprendi na net: isso aqui é tipo um return 0 de assembly. serviço 10 fecha o programa bonito
	ecall
		
# código que calcula o fatorial (não recursivo e não funcional) de um número fornecido. não considera entradas negativas
# tentando comentar todas as linhas possíveis pra ver se eu guardo as ideias do que to escrevendo #ehtoiss
	
