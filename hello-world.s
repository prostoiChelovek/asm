global _start

%macro print 2             ; print buf, count
    mov rax, 1             ; write(
    mov rdi, 1             ;       fd=STDOUT,
    mov rsi, %1            ;       buf,
    mov rdx, %2            ;       count
    syscall                ; )
%endmacro

section .text
_start:
    print $message, $message_len

    mov rax, 60            ; exit(
    mov rdi, 0             ;      EXIT_SUCCESS
    syscall                ; )

section .data
message: db "hello, world!"
message_len: equ $-message

