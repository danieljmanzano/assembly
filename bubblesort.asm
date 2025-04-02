# nome do codigo é autoexplicativo
	.data
	.align 2
vetor:  .word 1, 8, 3, 6, 2, 0, 10

	.text
	.align 0
	.globl main
main:
	la s0, vetor # carrega o vetor em s0
	
	addi t0, zero, 0 # i
	addi t1, zero, 0 # j
	addi s1, zero, 6 # tamanho do vetor 
	
loop1:
	beq t0, s1, sai_loop # caso i == 6, acabou todo o loop. aí vou para o fim
	li t1, 0 # toda vez que passo pelo loop 1, o j tem que estar zerado
	
loop2:
	beq t1, s1, proximo_i # caso j == 6, vou pro proximo_i (faz o i++ e volta pro loop1)
    
    	slli t2, t1, 2 # slli shifta para esquerda quantos bits voce colocar no fim do comando ali, entao to fazendo t2 = j * 4. vou usar para acessar os endereços no vetor
    	add t2, s0, t2 # agora t2 tem de fato o endereço do vetor[j]
    	lw t3, 0(t2) # t3 = vetor[j]
    	lw t4, 4(t2) # t4 = vetor[j + 1]
	blt t4, t3, swap # se vetor[j + 1] < vetor[j], troca
	# detalhe: caso nao faça o swap, ele vai direto pro proximo_j aqui embaixo e continua o loop
proximo_j:
	addi t1, t1, 1
	j loop2
	
swap: 
	sw t4, 0(t2)
	sw t3, 4(t2)
	j proximo_j
	
proximo_i:
	addi t0, t0, 1
	j loop1

sai_loop:
    	li t0, 0 # indice inicial
    	li t1, 7 # tamanho do vetor
    
print_loop:
	li a7, 1 # serviço pra printar int
    	bge t0, t1, fim # se índice >= tamanho, sai
    	slli t2, t0, 2 # multiplica índice por 4
    	add t2, s0, t2 # calcula endereço 
    	lw a0, 0(t2) # carrega o valor para impressão
    	ecall            
    
    	# isso aqui embaixo é pra printar um espaço entre os numeros
    	li a7, 11 # serviço printa char
    	li a0, 32 # 32 == espaço em ascii   
    	ecall
    
    	addi t0, t0, 1 # incrementa o indice
    	j print_loop
    
fim:
    	li a7, 10
    	ecall
	