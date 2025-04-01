# comentando absolutamente tudo pra nao sobrar nada nao explicado aqui (copiei uma parte do fatorial_funcional alias, os comentarios tao iguais por aí tambem rsrs)
# agora vamo de fatorial recursivo
	
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
	
	# a ideia aqui é que vou decrementando a partir do numero de entrada e salvando ele. quando chegar no fim (estiver como 0), vou voltando multiplicando tudo
fatorial:
	# empilhar ra e a0. preciso ter esses dois guardados pra nao perder as estribeira da recursão
	addi sp, sp, -8 # movo 8 bytes do sp porque vou precisar empilhar o valor inicial do numero do fatorial (a0) e o ra pro retorno (2 * word == 8 bytes)
	sw ra, 0(sp) # guarda na primeira posição de palavra do sp o ra
	sw a0, 4(sp) # guarda na segunda posição de palavra do sp (por isso o 4, fica na palavra seguinte ao ra) o a0

	beq a0, zero, retorna_um # compara a condição de parada da recursão. caso seja verdade, retorna 1 (caso base de fatorial)
	
	addi a0, a0, -1 # decrementa o contador
	jal fatorial # chama a função recursiva
	
	addi a0, a0, 1 # incrementa o a0 só pro caso base (pq quando chegar aqui ele vai estar como 0)
	mul a1, a1, a0 # faz a multiplicação de fato
	j sai_fat # volta na recursão
	
retorna_um: # isso aqui é chamado quando chegar meu a0 em 0. vou retornando a partir de 1 e vai pro 'sai_fat'
	addi a1, zero, 1
	
sai_fat: # agora que chegou no fim, vai desempilhando tudo (é aqui que volta a recursão)
	lw ra, 0(sp) # desempilha o último ra
	lw a0, 4(sp) # desempilha o último a0
	addi sp, sp, 8 # anda o sp depois de desempilhar esses dois
	jr ra # aqui eu de fato vou voltando nas chamadas
