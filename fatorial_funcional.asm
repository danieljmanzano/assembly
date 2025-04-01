# comentando absolutamente tudo pra nao sobrar nada nao explicado aqui
# caso nao tenha ficado claro pelo nome do codigo, fazendo o fatorial usando função
	
	.data
	.align 0
str1:   .asciz "digite um numero: "
str2:   .asciz "resultado: "

	.text
	.align 2
	.globl main
	
main:
	# imprimir a primeira string pra entrada
	li a7, 4
	la a0, str1
	ecall
	
	# ler a entrada
	li a7, 5
	ecall
	
	# salvar a entrada
	add s0, zero, a0
	
	# pula pra função fatorial. jal guarda no ra o endereço de retorno (podemos omitir isso usando ele), entao nem preocupa com a volta
	jal fatorial 
	
	# salvo o resultado da função em s1 (a1 vai estar definindo o resultado da funçao ali embaixo). isso acontece depois da volta da funçao 'fatorial'
	add s1, zero, a1
	
	# imprimir a segunda string pra saída
	li a7, 4
	la a0, str2
	ecall
	
	# imprimir fatorial
	li a7, 1
	add a0, zero, a1 
	ecall
	
	# encerra o programa
	li a7, 10
	ecall
	
	# função fatorial
	# convenção: a0 e a1 == parâmetro ou retorno; a2 até a7 == parâmetro 
	# aqui vamo fazer: a0 == numero a ser calculado; a1 == fatorial calculado
	# obs.: poderiamos nao usar o t0 como contador e ir mexendo em a0 no lugar. nao fiz isso pq desse jeito (com um contador a parte) fica mais parecido com o outro fatorial que fiz
fatorial:
	addi a1, zero, 1 # em a1 (que vai ser o resultado), ja vou carregar 1
	add t0, zero, a0 # em t0 tenho meu contador. começa com o valor da entrada e vai decrementando até 0
	
loop:	# no loop faz aquela logica basica do fatorial
	beq t0, zero, sai_loop # quanto o contador chega em 0, posso sair do loop
	mul a1, t0, a1 # multiplica s1 pelo contador
	addi t0, t0, -1 # decrementa o contador
	j loop
	
sai_loop:
	jr ra # sai da função fatorial pra onde ela tinha sido chamada
