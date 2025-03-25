	.data
	.align 0
buffer: .asciz "parabens ze"
destino:.word # word == 4 bytes, o tanto que preciso para um ponteiro (destino funciona como ponteiro)

	.text
	.align 2
	.globl main
main:  # t1 vai ser meu contador (para saber o tamanho da string de origem), t0 vai conter o byte da string e s0 vai endereçar a string
	li t1, 0 # inicializo o contador
	la s0, buffer # endereça a string no s0

loop1: # loop para contar as letras da string (+ '\0')
	lb t0, 0(s0) # endereço o caracter da string no t0
	addi s0, s0, 1 # avanço na string
	addi t1, t1, 1 # incremento o contador
	bne t0, zero, loop1 # caso ainda nao seja o '\0' em t0, continuo no loop
	
	#fora do loop1
	li a7, 9 # 9 == serviço para alocar memória na heap (sbrk)
	add a0, zero, t1 # coloco o tamanho da string (t1) em a0 para alocar
	ecall # aqui, vou ter a0 apontando para o primeiro byte do espaço alocado
	
	# destino vai apontar para t2, aí vou escrever a string em t2
	la t2, destino # endereça a string destino no t2
	sw a0, 0(t2) # armazena o valor de a0 (ponteiro para memória alocada) no endereço apontado por t2. basicamente coloco o destino na memoria alocada
	la s0, buffer # volto o s0 pro começo da string origem
	la t2, destino 
	lw s1, 0(t2)
	
loop2: # t0 vai ser o aux que manda um caracter de uma string pra outra
	lb t0, 0(s0)
	sb t0, 0(s1)
	addi s0, s0, 1
	addi s1, s1, 1
	bne t0, zero, loop2
	
	# impressão da string copiada
	li a7, 4
	la t2, destino 
	lw a0, 0(t2)
	ecall
	
	li a7, 10
	ecall
	
# nome autoexplicativo do programa. só refizemos o strcpy usando alocação dinâmica
# sinceramente, nao entendi bem as linhas de 24 até 28... o codigo funciona mas nao peguei a ideia dessa parte
	