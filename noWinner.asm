; noWinner.asm
; Anand T. Egan
; 2023-12-15
;
; For CS 301 Fall 2023
; Source Code for the noWinner function to be called by customttt.cpp
; Checks if there is no winner

BITS 64

; board - rcx
; BOARD_SIZE - rdx

section .data
    noWinnerString db `NO WINNER!\n`,0 ; Null-terminated string
    format db "%s", 0  ; Format string for printf
    testNum db "NUM: %d... ", 0

section .text
    global noWinner
    extern printf
    extern exit

noWinner:
; int countAllGone
mov r11, 0

; Outer loop counter (i)
mov r8, 0 ; i = 0

outer_loop_start:
    mov r9, 0 ; j = 0
    inner_loop_start:

        ; calculate the correct spot to index
        ; r10 is the register of the calculated index
        mov r10, r9
        imul r10, 10
        add r10, r8

        ; Return the element of the array
        movzx rdi, byte [rcx + r10] ; Load the byte from board[indexY][indexX] and zero-extend to 64 bits

        cmp rdi, 45
        jne skip
        add r11, 1 ; countAllGone++
        skip: 

        add r9, 1 ; j++
        cmp r9, rdx ; j < BOARD_SIZE
        jl inner_loop_start

    add r8, 1 ; i++
    cmp r8, rdx ; i < BOARD_SIZE
    jl outer_loop_start

cmp r11, 0
je noWinnerOutput
jmp end

noWinnerOutput:
    ; Align the stack to 16 bytes
    sub rbp, 8

    ; Call printf
    mov rdx, noWinnerString  ; Argument for printf
    mov rcx, format ; Format specifier
    call printf

    ; Clean up the stack
    add rbp, 8

    ; end the program
    mov rcx,0
    call exit

end:
mov rax, 0
ret