	.data  # dados do código
hello:  .asciz "hello world"  # string a ser impressa

	.text
	.globl main
main:
	# imprimir a string hello
	# a7: serviço 4 da ecall 
	# a0: endereço do 1° byte da string
	
	# carregar o valor 4 no registrador a7
	li a7, 4
	
	# carregar o endereço do 1° byte no registrador a0
	la a0, hello
	
	# chamada da ecall
	ecall
	
	# finalizar o programa 
	# a7: serviço 10
	li a7, 10
	ecall

# hello world neles. to usando o rars pra programar em assembly, então talvez os códigos fiquem meio estranhos visualmente pelo github
# o que importa é que ta funcionando aqui #ehtoiss