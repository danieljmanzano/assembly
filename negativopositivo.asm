	.data # espaço dos dados
	.align 0 # quero endereçar por byte (bom pra string), então align 0
str1:   .asciz "positivo "
str2:   .asciz "negativo "

 	.text # espaço do código
 	.align 2 # align 2 para as instruçoes que vou usar
 	.globl main
 main:  
	addi a7, zero, 5 # 5: serviço para ler um inteiro
	ecall
	add s0, a0, zero
	blt s0, zero, print_neg # verifica se o valor em s0 é menor que 0. caso sim, vai para a label print_neg (blt == branch on less than); caso nao, segue reto
	
	# imprime str1 caso nao tenha sido negativo (não desviou, veio pra cá)
	addi a7, zero, 4
	la a0, str1
	ecall
	j the_end # j == jump incondicional. se chegou aqui no código já printamos o hello world positivo e pulamos para o fim
	
	# imprime str2 caso tenha sido negativo (desviou no blt)
print_neg: 
	addi a7, zero, 4
	la a0, str2
	ecall
	
	# imprime o número lido
the_end:
	addi a7, zero, 1
	add a0, zero, s0
	ecall
	addi a7, zero, 10
	ecall

# código simples que vai receber um número inteiro e printar se ele é negativo ou positivo (e depois printar o próprio numero)