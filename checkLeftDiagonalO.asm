; checkLeftDiagonalO.asm
; Anand T. Egan
; 2023-12-15
;
; For CS 301 Fall 2023
; Source Code for the checkLeftDiagonalO function to be called by customttt.cpp
; Checks if the left diagonal win condition was made by player O

BITS 64

section .data
    oWonString db `PLAYER O HAS WON!\n`,0 ; Null-terminated string
    format db "%s", 0  ; Format string for printf

section .text
    global checkLeftDiagonalO
    extern printf
    extern exit

checkLeftDiagonalO:
    ; Initialize countToWin
    mov r11, 0

    ; Loop through the diagonal elements
    mov r8, 0  ; i = 0
    mov r9, 0  ; j = 0
diagonalLoopStart:
    ; Calculate the index in the array
    mov r10, r8
    imul r10, 10
    add r10, r9

    ; Load the element from the board
    movzx rdi, byte [rcx + r10] ; Load the byte from board[indexY][indexX] and zero-extend to 64 bits

    ; Check if the element is 'O'
    cmp rdi, 79
    jne diagonalSkip
    add r11, 1 ; Increment countToWin
diagonalSkip:

    ; Increment indices
    add r8, 1 ; i++
    add r9, 1 ; j++

    ; Check if the end of the diagonal is reached
    cmp r8, rdx ; i < BOARD_SIZE
    jl diagonalLoopStart

    ; Check if countToWin is equal to BOARD_SIZE
    cmp r11, rdx
    je xHasWon

    ; If not, return
    jmp end

xHasWon:
    ; Align the stack to 16 bytes
    sub rsp, 8

    ; Call printf
    mov rdx, oWonString  ; Argument for printf
    mov rcx, format ; Format specifier
    call printf

    ; Clean up the stack
    add rsp, 8

    ; End the program
    mov rcx, 0
    call exit

end:
    mov rax, 0
    ret