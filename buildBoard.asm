; customttt.asm
; Anand T. Egan
; 2023-12-15
;
; For CS 301 Fall 2023
; Source Code for the buildBoard function to be called by customttt.cpp
; Creates a blank board for the tic tac toe game

BITS 64

; board - rcx
; BOARD_SIZE - rdx

section .text
global buildBoard

buildBoard:
    mov r8, 0      ; Initialize outer loop counter (i)
    mov r9, 0      ; Initialize inner loop counter (j)

outer_loop:
    mov r9, 0
    cmp r8, rdx    ; Compare outer loop counter with BOARD_SIZE
    jge outer_loop_end ; If i >= BOARD_SIZE, exit the outer loop
    
inner_loop:
    cmp r9, rdx    ; Compare inner loop counter with BOARD_SIZE
    jge inner_loop_end ; If j >= BOARD_SIZE, exit the inner loop

    ; set up the index to set the char of the blank board
    mov r10, r9
    imul r10, 10
    add r10, r8

    mov byte [rcx+r10], '-' ; sets the char of the board in that spot to `-`

    add r9, 1      ; Increment inner loop counter
    jmp inner_loop ; Repeat the inner loop
    
inner_loop_end:
    add r8, 1      ; Increment outer loop counter
    jmp outer_loop ; Repeat the outer loop
    
outer_loop_end:
    ret
