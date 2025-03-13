section .data
    msg db "Hello, World!", 0xA 
    len equ $-msg  

section .text
    global _start

_start:
    mov rax, 1       ; syscall: sys_write
    mov rdi, 1       ; File descriptor: stdout
    mov rsi, msg     ; Ponteiro para a mensagem
    mov rdx, len     ; Tamanho da mensagem
    syscall          ; Chamada do sistema

    mov rax, 60      ; syscall: sys_exit
    xor rdi, rdi     ; Código de saída 0
    syscall          ; Chamada do sistema
