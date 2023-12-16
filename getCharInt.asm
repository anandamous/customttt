; getCharInt.asm
; Anand T. Egan
; 2023-12-15
;
; For CS 301 Fall 2023
; Source Code for the getCharInt function to be called by the getChar function from customttt.cpp
; Grabs the int of an indexed char
; Used for the getChar function in the customttt.cpp main C++ code

BITS 64

; board - rcx
; BOARD_SIZE - rdx
; indexX - r8
; indexY - r9

section .text
global getCharInt

getCharInt:
    ; calculate the correct spot to index
    ; r10 is the register of the calculated index
    mov r10, r9
    imul r10, 10
    add r10, r8

    ; Return the element of the array
    movzx rax, byte [rcx + r10] ; Load the byte from board[indexY][indexX] and zero-extend to 64 bits
    ret
