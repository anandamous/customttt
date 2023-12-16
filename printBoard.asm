; printBoard.asm
; Anand T. Egan
; 2023-12-15
;
; For CS 301 Fall 2023
; Source Code for the printBoard function to be called by customttt.cpp
; Prints the entire board out to be displayed for the players

BITS 64

; board - rcx
; BOARD_SIZE - rdx

section .data
    initialSpace db `  `,0
    space db ` `,0
    newline db `\n`,0
    formatString db "%s", 0
    iValue db "%d ", 0
    arrayChar db "%c ", 0

section .text
    global printBoard

printBoard:
    extern printf
    mov r14, rcx
    mov r15, rdx 

    ; Print two spaces
    ; Align the stack to 16 bytes
    sub rbp, 8

    ; Call printf
    mov rdx, initialSpace  ; Argument for printf
    mov rcx, formatString ; Format specifier
    call printf

    ; Clean up the stack
    add rbp, 8
    mov rcx, r14
    mov rdx, r15

    ; Loop start
    mov r13, 0
    printFirstRow:
        mov r14, rcx
        mov r15, rdx

        ; Align the stack to 16 bytes
        sub rbp, 8

        ; Call printf
        mov rdx, r13       ; Copy rax to rdx for printf
        mov rcx, iValue    ; Format string
        call printf

        ; Clean up the stack
        add rbp, 8
        mov rcx, r14
        mov rdx, r15

        ; Increment loop counter (i)
        add r13, 1

        ; Compare loop counter with BOARD_SIZE
        cmp r13, r15
        ; Jump to loop_start if i < BOARD_SIZE
        jl printFirstRow

    ; Print a new line
    ; Align the stack to 16 bytes
    sub rbp, 8

    ; Call printf
    mov rdx, newline  ; Argument for printf
    mov rcx, formatString ; Format specifier
    call printf

    ; Clean up the stack
    add rbp, 8
    mov rcx, r14
    mov rdx, r15

    ; Outer loop (i)
    mov r13, 0 ; i = 0

    outer_loop_start:
        ; print column number
        mov r14, rcx
        mov r15, rdx

        ; Align the stack to 16 bytes
        sub rbp, 8

        ; Call printf
        mov rdx, r13
        mov rcx, iValue    ; Format string
        call printf

        ; Clean up the stack
        add rbp, 8
        mov rcx, r14
        mov rdx, r15

        ; Inner loop (j)
        mov r12, 0 ; j = 0

        inner_loop_start:
            ; Print character within the board
            ; ...

            ; Get the index to grab the character from the 2d array
            mov r10, r13
            imul r10, 10
            add r10, r12

            movzx rax, byte [rcx + r10] ; Load the byte from board[indexY][indexX] and zero-extend to 64 bits

            ; Align the stack to 16 bytes
            sub rbp, 8

            ; Call printf
            mov rdx, rax
            mov rcx, arrayChar
            call printf

            ; Clean up the stack
            add rbp, 8
            mov rcx, r14
            mov rdx, r15

            ; Increment inner loop counter (j)
            add r12,1

            ; Compare inner loop counter with BOARD_SIZE
            cmp r12, r15

            ; Jump to inner_loop_start if j < BOARD_SIZE
            jl inner_loop_start

        ; Print a new line
        ; Align the stack to 16 bytes
        sub rbp, 8

        ; Call printf
        mov rdx, newline  ; Argument for printf
        mov rcx, formatString ; Format specifier
        call printf

        ; Clean up the stack
        add rbp, 8
        mov rcx, r14
        mov rdx, r15

        ; Increment outer loop counter (i)
        inc r13

        ; Compare outer loop counter with BOARD_SIZE
        cmp r13, r15

        ; Jump to outer_loop_start if i < BOARD_SIZE
        jl outer_loop_start

    ; Exit program
    mov rax, 0
    ret

