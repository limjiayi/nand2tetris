// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(LOOP)
    @SCREEN
    D=A
    @addr
    M=D   // addr = the screen's base address

    @KBD
    D=M
    @BLACK
    D;JNE // Detected keypress, go to BLACK
    @WHITE
    D;JEQ // No keypress detected, go to WHITE

(BLACK)
   @colour
   M=-1   // -1 = 1111111111111111 in 2's complement
   @DRAW
   0;JMP

(WHITE)
    @colour
    M=0
    @DRAW
    0;JMP

(DRAW)
    @addr
    D=M   // Current memory address
    @KBD
    D=D-A // A = the keyboard's base memory address
    @LOOP
    D;JEQ // Done with drawing, so go back to the main loop

    @colour
    D=M   // D = current colour
    @addr
    A=M   // We want to change the pixel at the location specified by M
    M=D   // Change the pixel to the desired colour

    @addr
    M=M+1 // Increment the address

    @DRAW
    0;JMP