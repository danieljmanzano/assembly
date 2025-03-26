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
	
	la t2, destino # t2 vai estar com o endereço do destino
	sw a0, 0(t2) # armazena o valor de a0 (ponteiro para memória alocada) no endereço apontado por t2. meio que to colocando o destino apontando pra memoria alocada (destino = a0)
	# basicamente, essas duas ultimas linhas equivalem a um destino = malloc()
	la s0, buffer # volto o s0 pro começo da string origem
	la t2, destino # aqui meio que to só garantindo que t2 tenha o destino mesmo (todo aquele lance de os registradores t serem temporarios, mas aqui é quase ctz que nao precisava disso)
	lw s1, 0(t2) # le o valor armazenado no endereço de t2 (ou seja, o valor de destino, que é a0, onde ele ta apontando) e coloca em s1. s1 funciona como se fosse o proprio ponteiro destino
	
loop2: # t0 vai ser o aux que manda um caracter de uma string pra outra
	lb t0, 0(s0) # pega o caracter do buffer
	sb t0, 0(s1) # passa para a string destino 
	addi s0, s0, 1 # anda na string
	addi s1, s1, 1 # anda na string
	bne t0, zero, loop2 # enquanto nao for '\0' continuo voltando no loop
	
	# impressão da string copiada
	li a7, 4 # 4 == serviço de impressão de string
	la t2, destino # denovo, meio que to garantindo que no t2 ta o que eu to pensando (professora falou que é redundante mesmo, mais pra fixar)
	lw a0, 0(t2) # coloco em a0 o que quero printar
	ecall 
	
	li a7, 10
	ecall
	
# nome autoexplicativo do programa. só refizemos o strcpy usando alocação dinâmica
# tentando entender o codigo 100%, alguns comentarios talvez sejam errados mas tamo melhorando
	
