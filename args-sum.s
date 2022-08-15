global _start

section .text                   
_start:                         
    pop rax                     ; rax = argc; stack pointer on argv now

    mov rbx, [rsp + 8]          ; rbx = argv[1] - address of the second string array
    mov rcx, 0                  ; length
_loop:
    mov bpl, byte [rbx + rcx]   ; bpl = argv[0][rcx]
    inc rcx                     ; length++
    cmp bpl, 0x00
    jne _loop                   ; if (bpl != \0)

    mov [arglen], rcx ; TODO use stack
    mov rax, 1                  ; write(
    mov rdi, 1                  ;       fd=STDOUT,
    mov rsi, arglen             ;       buf,
    mov rdx, 1                  ;       count
    syscall                     ; )

    mov rax, 60     ; exit (
    mov rdi, 0      ;       EXIT_SUCCESS
    syscall         ; )

section .bss
arglen: resb 4
