** CMSC 313 - Homework 11: Data to ASCII Hex Converter (+ Extra Credit) **

Author: Mohammad Aliyaan Zahid
Description
This program reads a fixed array of byte data (inputBuf) and converts each byte into a two-digit ASCII hexadecimal value. The output string is placed into outputBuf and printed to the terminal.

This program also completes the extra credit requirement: the full byte-to-ASCII conversion is handled by the translate_byte subroutine.

Example output:
83 6A 88 DE 9A C3 54 9A

How to Run on UMBC GL Server
1. Copy the hw11.asm file to your UMBC GL account/ server'

2. SSH into the GL server:
ssh yourusername@gl.umbc.edu

3. Assemble the code:
nasm -f elf32 -g -F dwarf -o hw11.o hw11.asm

4. Link the object file to create an executable:
ld -m elf_i386 -o hw11translate hw11.o

5. Run the program:
./hw11translate

You should see:
83 6A 88 DE 9A C3 54 9A

** What the Program Produces **
- Takes an array of bytes (inputBuf)
- Converts each byte into its two-digit ASCII hexadecimal representation
- Outputs a string of hex values separated by spaces
- Replaces the final space with a newline (\n)


** Extra Credit Completion: **

The translate_byte subroutine:
- Receives a full byte (AL)
- Splits it into high and low nibbles
- Converts each nibble to an ASCII hex character
- Stores both characters directly into outputBuf


Thank You!