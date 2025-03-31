.data
    .align 0
msg:    .asciz "resultado: "

.text
    .align 2
    .globl main
    .globl calcular_fatorial
    .globl imprimir_resultado

# Função principal
main:
    # Lê número de entrada
    addi a7, zero, 5        # serviço 5: leitura de int
    ecall
    
    # Chama função para calcular fatorial
    jal ra, calcular_fatorial
    
    # Chama função para imprimir resultado
    jal ra, imprimir_resultado
    
    # Encerra o programa
    addi a7, zero, 10       # serviço 10: exit
    ecall

# Função para calcular fatorial
# Entrada: a0 = número para calcular fatorial
# Saída: a0 = resultado do fatorial
calcular_fatorial:
    # Salva registradores na pilha
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s0, 4(sp)
    sw s1, 0(sp)
    
    # Inicializações
    add s0, zero, a0        # guarda o número de entrada em s0
    addi s1, zero, 1        # s1 guarda o resultado (inicia com 1)
    
    # Verifica casos especiais (0! e 1! = 1)
    beq s0, zero, fim_calculo
    addi t0, zero, 1
    beq s0, t0, fim_calculo
    
    # Loop de cálculo do fatorial
    addi t0, zero, 2        # t0 é o contador (começa em 2)
loop:
    mul s1, s1, t0          # multiplica resultado pelo contador
    addi t0, t0, 1          # incrementa contador
    bge t0, s0, fim_calculo # se contador >= número, termina
    jal zero, loop          # continua no loop

fim_calculo:
    add a0, zero, s1        # coloca resultado em a0 para retorno
    
    # Restaura registradores
    lw s1, 0(sp)
    lw s0, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    jalr zero, ra, 0        # retorna ao chamador

# Função para imprimir resultado
# Entrada: a0 = número para imprimir
imprimir_resultado:
    # Salva registradores na pilha
    addi sp, sp, -8
    sw ra, 4(sp)
    sw a0, 0(sp)
    
    # Imprime mensagem
    addi a7, zero, 4        # serviço 4: imprimir string
    lui a0, %hi(msg)        # carrega parte alta do endereço
    addi a0, a0, %lo(msg)   # carrega parte baixa
    ecall
    
    # Imprime número
    addi a7, zero, 1        # serviço 1: imprimir int
    lw a0, 0(sp)            # recupera o número da pilha
    ecall
    
    # Restaura registradores
    lw ra, 4(sp)
    addi sp, sp, 8
    jalr zero, ra, 0        # retorna ao chamador