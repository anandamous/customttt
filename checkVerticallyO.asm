; checkVerticallyO.asm
; Anand T. Egan
; 2023-12-15
;
; For CS 301 Fall 2023
; Source Code for the checkVerticallyO function to be called by customttt.cpp
; Checks if the vertical win condition was made by player O

BITS 64

; board - rcx
; BOARD_SIZE - rdx

section .data
    oWonString db `PLAYER O HAS WON!\n`,0 ; Null-terminated string
    format db "%s", 0  ; Format string for printf

section .text
    global checkVerticallyO:
    extern printf
    extern exit

checkVerticallyO:
; // for(int i = 0; i < BOARD_SIZE; i++) { - OUTER LOOP START
; Outer loop counter (i)
mov r8, 0 ; i = 0
outer_loop_start:
    ; // int countToWin = 0;  
    mov r11, 0
    ; // for(int j = 0; j < BOARD_SIZE; j++) { - INNER LOOP START
    mov r9, 0 ; j = 0
    inner_loop_start:
        ; // if(board[i][j] == 'X') { - CHECK IF X START
        ; calculate the correct spot to index
        ; r10 is the register of the calculated index
        mov r10, r9
        imul r10, 10
        add r10, r8

        ; Return the element of the array
        movzx rdi, byte [rcx + r10] ; Load the byte from board[indexY][indexX] and zero-extend to 64 bits

        cmp rdi, 79
        jne skip
        add r11, 1 ; countAllGone++
        skip: 
        ; // } - CHECK IF X END

        add r9, 1 ; j++
        cmp r9, rdx ; j < BOARD_SIZE
        jl inner_loop_start
    ; // } - INNER LOOP END

    cmp r11, rdx
    je xHasWon

    add r8, 1 ; i++
    cmp r8, rdx ; i < BOARD_SIZE
    jl outer_loop_start
; // } - OUTER LOOP END

jmp end

xHasWon:
; Align the stack to 16 bytes
sub rbp, 8

; Call printf
mov rdx, oWonString  ; Argument for printf
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