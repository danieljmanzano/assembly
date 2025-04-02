# aloco dinamicamente um vetor de 5 int, somo os numeros e printo
	.data
	.align 2
msg:    .asciz "resultado da soma dos numeros: "

	.text
    	.align 2
    	.globl main
main:
    	li a7, 9 # serviço de alocação dinâmica (sbrk)
    	li a0, 20 # tamanho a ser alocado (5 ints * 4 bytes)
    	ecall
    	
    	addi s0, a0, 0 # s0 = a0 (guarda endereço base do vetor)
    	addi t3, s0, 0 # t3 = s0 (ponteiro para percorrer vetor)

    	li t1, 0 # t1 vai ser o contador
    	li t5, 5 # t5 é o tamanho do vetor
    
loop_entrada:
    	beq t1, t5, sai_loop # quando contador == 5, sai
    
    	li a7, 5 # serviço para ler int
    	ecall
    
    	sw a0, 0(t3) # armazena o número lido na posição atual
    	addi t3, t3, 4 # avança ponteiro (4 bytes por int)
    	addi t1, t1, 1 # incrementa contador
    
    	j loop_entrada
    
sai_loop:
    	addi t3, s0, 0 # t3 = s0 (reinicia ponteiro para início)
    	li t1, 0 # reinicializa contador
    	li t2, 0 # t2 = acumulador da soma
    
loop_soma:
    	beq t1, t5, fim # quando contador == 5, termina
    
    	lw t4, 0(t3) # carrega número do vetor
    	add t2, t2, t4 # acumula na soma
    	
    	addi t3, t3, 4 # avança ponteiro
    	addi t1, t1, 1 # incrementa contador
    	
    	j loop_soma
    
fim:
    	li a7, 4 # imprime mensagem
    	la a0, msg
    	ecall
    
    	li a7, 1 # imprime resultado
    	addi a0, t2, 0 # a0 = t2
    	ecall
    
    	li a7, 10       
    	ecall