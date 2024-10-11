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
    BACKGROUND: .long 0xffffffff
