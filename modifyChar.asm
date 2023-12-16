; modifyChar.asm
; Anand T. Egan
; 2023-12-15
;
; For CS 301 Fall 2023
; Source Code for the modifyChar function to be called by customttt.cpp
; Modifies an indexed position with a specified character

BITS 64

; board - rcx
; BOARD_SIZE - rdx
; indexX - r8
; indexY - r9
; replaceChar - [rsp+40]

section .text
global modifyChar

modifyChar:
    ; Calculate the correct spot to index
    mov r10, r8
    imul r10, 10
    add r10, r9

    ; Access replaceChar from the register
    movzx r11, byte [rsp+40]

    ; Put the char at the specified index
    mov byte [rcx + r10], r11b  ; Use r11 as the source register
    ret