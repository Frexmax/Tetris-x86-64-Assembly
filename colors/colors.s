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
    BLACK: .quad 0xff000000 
    WHITE: .quad 0xffffffff
    
    IBLOCKCOLOR: .quad 0xffffff00
    JBLOCKCOLOR: .quad 0xffff0000
    LBLOCKCOLOR: .quad 0xff007fff
    OBLOCKCOLOR: .quad 0xff00ffff
    TBLOCKCOLOR: .quad 0xff800080
    SBLOCKCOLOR: .quad 0xff00ff00
    ZBLOCKCOLOR: .quad 0xff0000ff

    // BACKGROUND: .quad 0xffffffff
    // BACKGROUND: .quad 0xff505050
    BACKGROUND: .quad 0xff7a1529



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
