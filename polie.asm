bits 64

extern GetStdHandle
extern WriteConsoleA
extern ExitProcess
extern ReadConsoleA

section .data
    message_polite db 'Tu es poli(e)', 10
    message_rude db 'Sale con', 10

section .bss
    buffer resb 255
    written resq 1

section .text
    global main

main:
    mov rcx, -11
    call GetStdHandle

    mov rcx, rax
    mov rdx, buffer
    mov r8, 255
    mov r9, written
    call ReadConsoleA

    mov rsi, buffer
    mov rdi, 'bjr'
    call compare_strings_unicode

    cmp rax, 0
    je polite_message
    jmp rude_message

polite_message:
    mov rcx, rax
    mov rdx, message_polite
    mov r8, 12
    mov r9, written
    call WriteConsoleA
    jmp exit_program

rude_message:
    mov rcx, rax
    mov rdx, message_rude
    mov r8, 9
    mov r9, written
    call WriteConsoleA

exit_program:
    xor eax, eax
    call ExitProcess

compare_strings_unicode:
    xor rax, rax
compare_loop_unicode:
    mov ax, [rsi] 
    cmp ax, [rdi]
    je compare_next_unicode
    ret
compare_next_unicode:
    add rsi, 2
    add rdi, 2
    cmp ax, 0
    jne compare_loop_unicode
    ret
