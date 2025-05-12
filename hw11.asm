; -------------------------------------------------
; CMSC 313 - HW#11 - Print Data in ASCII Hex + Extra Credit
; Author: Mohammad Aliyaan Zahid
; Description:
; This program reads an array of bytes and converts each byte
; into a two-digit ASCII hexadecimal string. The full byte-to-ASCII
; translation is performed in a subroutine to meet extra credit requirements.
; The output is stored in outputBuf and printed to the screen.
; -------------------------------------------------

section .data
; Input buffer of data to convert
inputBuf db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputLen equ 8           ; Number of bytes in inputBuf

section .bss
; Output buffer for resulting ASCII string
outputBuf resb 80

section .text
global _start

_start:
    ; -------------------------------------------------
    ; Main program loop
    ; Loops through each byte in inputBuf
    ; Calls subroutine to translate each byte to ASCII hex
    ; Adds space after each byte
    ; -------------------------------------------------
    mov esi, inputBuf     ; ESI → input buffer
    mov edi, outputBuf    ; EDI → output buffer
    mov ecx, inputLen     ; Counter for number of bytes

process_loop:
    lodsb                 ; Load byte from inputBuf into AL
    push ecx              ; Save loop counter
    call translate_byte   ; Extra credit subroutine to convert byte
    pop ecx               ; Restore loop counter

    mov al, ' '           ; Add space after translated byte
    stosb
    loop process_loop

    ; Replace last space with newline character
    dec edi
    mov byte [edi], 0x0A

    ; -------------------------------------------------
    ; Print output buffer to screen
    ; -------------------------------------------------
    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    mov ecx, outputBuf    ; pointer to buffer
    sub edi, outputBuf
    mov edx, edi          ; length of string
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; -------------------------------------------------
; Subroutine: translate_byte (Extra Credit)
; Description:
;   Receives byte in AL
;   Splits into high and low nibbles
;   Converts both nibbles to ASCII hex characters
;   Stores result directly in output buffer
; This satisfies extra credit: full translation in subroutine
; -------------------------------------------------
translate_byte:
    push eax
    push ecx

    mov ah, al            ; Save original byte in AH
    shr ah, 4             ; Isolate high nibble into AH
    and al, 0Fh           ; Isolate low nibble into AL

    ; Convert high nibble
    mov al, ah
    call nibble_to_ascii
    stosb

    ; Convert low nibble
    pop ecx               ; Restore ECX
    pop eax               ; Restore AL (original byte)
    and al, 0Fh
    call nibble_to_ascii
    stosb
    ret

; -------------------------------------------------
; Subroutine: nibble_to_ascii
; Description:
;   Converts nibble value in AL (0x0 - 0xF)
;   Returns ASCII character ('0'-'9', 'A'-'F') in AL
; -------------------------------------------------
nibble_to_ascii:
    cmp al, 9
    jbe is_digit
    add al, 55            ; Convert 0xA-0xF to 'A'-'F'
    ret
is_digit:
    add al, '0'           ; Convert 0x0-0x9 to '0'-'9'
    ret
