/*
    Color format: 32-bit number: RGBA
        - going from least to most significant bits
            1. first 8 bits (1 - 8): red component
            2. next 8 bits (9 - 16): green component
            3. next 8 bits (17 - 24): blue component
            4 last 8 bits (25 - 32): alpha component

        - alpha compoment: scales from 0 to 255
            1. 0 - transparent
            2. 255 - fully visible
    */

.data
    BLACK: .long 0xff000000 
    WHITE: .long 0xffffffff
    BLUE: .long 0xffff0000
    BACKGROUND: .long 0xffffffff


.macro setColorText # color to be decided
    subq $16, %rsp
    movb $0xff, -1(%rbp) # last arg
    movb $0x00, -2(%rbp)
    movb $0x00, -3(%rbp)   
    movb $0x00, -4(%rbp) # first arg
.endm

.macro setColorRAYWHITE
    subq $16, %rsp
    movb $0xff, -1(%rbp) # last arg
    movb $0xff, -2(%rbp)
    movb $0xff, -3(%rbp)
    movb $0xff, -4(%rbp) # first arg

.endm

.macro clearStackFromColor
    addq $16, %rsp
.endm
