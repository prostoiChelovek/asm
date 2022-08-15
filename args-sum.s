global _start

section .text                   
_start:                         
    pop rbx                     ; rbx = argc; stack pointer on argv now

_args_loop:                     ; loop over the arguments in reverse order
    cmp rbx, 0
    je _args_loop_end           ; if (rbx != 0) finish the loop 
    dec rbx
    mov rax, [rsp + rbx * 8]    ; rax = argv[rbx]

    mov rcx, 0                  ; length
_loop:
    mov bpl, byte [rax + rcx]   ; bpl = argv[rax][rcx]
    inc rcx                     ; length++
    cmp bpl, 0x00
    jne _loop                   ; if (bpl != \0)

    mov r8, rax
    mov [arglen], rcx
    mov rax, 1                  ; write(
    mov rdi, 1                  ;       fd=STDOUT,
    mov rsi, r8                 ;       buf,
    mov rdx, rcx                ;       count
    syscall                     ; )

    mov rax, 1                  ; write(
    mov rdi, 1                  ;       fd=STDOUT,
    mov rsi, space              ;       buf,
    mov rdx, 1                  ;       count
    syscall                     ; )

    add byte [arglen], 48       ; convert the digit to ascii
    mov rax, 1                  ; write(
    mov rdi, 1                  ;       fd=STDOUT,
    mov rsi, arglen             ;       buf,
    mov rdx, 1                  ;       count
    syscall                     ; )

    mov rax, 1                  ; write(
    mov rdi, 1                  ;       fd=STDOUT,
    mov rsi, newline            ;       buf,
    mov rdx, 1                  ;       count
    syscall                     ; )

    jmp _args_loop

_args_loop_end:

    mov rax, 60     ; exit (
    mov rdi, 0      ;       EXIT_SUCCESS
    syscall         ; )

section .bss
arglen: resb 4

section .data
newline: db `\n`
space: db ` `

