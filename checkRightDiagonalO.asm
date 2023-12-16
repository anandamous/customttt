; checkRightDiagonalO.asm
; Anand T. Egan
; 2023-12-15
;
; For CS 301 Fall 2023
; Source Code for the checkRightDiagonalO function to be called by customttt.cpp
; Checks if the right diagonal win condition was made by player O

BITS 64

section .data
    oWonString db `PLAYER O HAS WON!\n`,0 ; Null-terminated string
    format db "%s", 0  ; Format string for printf

section .text
    global checkRightDiagonalO
    extern printf
    extern exit

checkRightDiagonalO:
    ; Initialize countToWin
    mov r11, 0

    ; Loop through the diagonal elements
    mov r8, rdx  ; i = BOARD_SIZE - 1
    sub r8, 1
    mov r9, 0  ; j = BOARD_SIZE - 1
diagonalLoopStart:
    ; Calculate the index in the array
    mov r10, r9
    imul r10, 10
    add r10, r8

    ; Load the element from the board
    movzx rdi, byte [rcx + r10] ; Load the byte from board[indexY][indexX] and zero-extend to 64 bits

    ; Check if the element is 'O'
    cmp rdi, 79
    jne diagonalSkip
    add r11, 1 ; Increment countToWin
diagonalSkip:

    ; Increment indices
    sub r8, 1 ; i--
    add r9, 1 ; j++

    ; Check if the end of the diagonal is reached
    cmp r8, 0 ; i >= BOARD_SIZE
    jge diagonalLoopStart

    ; Check if countToWin is equal to BOARD_SIZE
    cmp r11, rdx
    je oHasWon

    ; If not, return
    jmp end

oHasWon:
    ; Align the stack to 16 bytes
    sub rbp, 8

    ; Call printf
    mov rdx, oWonString  ; Argument for printf
    mov rcx, format ; Format specifier
    call printf

    ; Clean up the stack
    add rbp, 8

    ; End the program
    mov rcx, 0
    call exit

end:
    ret
