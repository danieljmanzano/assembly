	.data
	.align 0
buffer: .space 10 # vou usar como entrada
destino:.space 10 # vou passar pra cá o que recebi na entrada
quebra:  .asciz "\n"
	
	.text
	.align 2
	li a7, 8 # 8 == serviço para ler string. usando ele, tenho que endereçar o buffer de entrada no a0 e colocar o número de bytes esperados em a1
	li a1, 10 # espero 10 bytes (9 char + '\0'), coloco em a1
	la a0, buffer # endereço o buffer (entrada) no a0
	ecall 
	
	
	la t0, buffer # coloco o endereço do buffer em t0
	la t1, destino # coloco o endereço do destino em t1
loop: # aqui vou passar os caracteres do buffer para o destino
	lb t2, 0(t0) # guardo um byte (lb == load byte) de t0 em t2
	sb t2, 0(t1) # coloco o byte de t2 em t1 (sb == store byte)
	beqz t2, fim # caso o conteúdo de t2 seja \0, cheguei ao fim da string e pulo pro fim (beqz == branch if equal zero)
	addi t0, t0, 1 # avança 1 byte em t0 
	addi t1, t1, 1 # mesmo de cima
	# comentario extra de algo que fiquei com dúvida antes: como t0 e t1 guardam endereço, eles funcionam como ponteiros e somar um significaria avançar um byte
	j loop # caso tenha chegado aqui, a string ainda nao acabou entao volto pro começo do loop

		
fim:
	li a7, 4 # 4 == serviço para printar string
	la a0, quebra # printo a quebra de linha antes da string. tenho frescura
	ecall
	
	li a7, 4 # mesmo de cima
	la a0, destino # endereça a string que quero printar em a0
	ecall
	
	li a7, 10  # fecha o programa. show de bola
	ecall
	
# codigo simulando um strcpy. recebo uma string, copio e printo ela 