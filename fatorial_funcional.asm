    .data
    .align 0
msg:    .asciz "resultado: "

    .text
    .align 2
    .globl main
    .globl calcular_fatorial
    .globl imprimir_resultado


main:

    addi a7, zero, 5       
    ecall
    
    jal ra, calcular_fatorial
    
    jal ra, imprimir_resultado
    
    addi a7, zero, 10      
    ecall


calcular_fatorial:

    addi sp, sp, -12
    sw ra, 8(sp)
    sw s0, 4(sp)
    sw s1, 0(sp)
    
  
    add s0, zero, a0        
    addi s1, zero, 1       
    

    beq s0, zero, fim_calculo
    addi t0, zero, 1
    beq s0, t0, fim_calculo
    

    addi t0, zero, 1       
loop:
    addi t0, t0, 1          
    mul s1, s1, t0         
    blt t0, s0, loop        

fim_calculo:
    add a0, zero, s1        
    

    lw s1, 0(sp)
    lw s0, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    jalr zero, ra, 0      


imprimir_resultado:

    addi sp, sp, -8
    sw ra, 4(sp)
    sw a0, 0(sp)
    

    addi a7, zero, 4        
    la a0, msg            
    ecall
    

    addi a7, zero, 1        
    lw a0, 0(sp)            
    ecall
    

    lw ra, 4(sp)
    addi sp, sp, 8
    jalr zero, ra, 0        