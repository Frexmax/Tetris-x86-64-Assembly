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

    IBLOCKCOLOR: .quad 0xffffff00       # light blue
    JBLOCKCOLOR: .quad 0xffff0000       # blue
    LBLOCKCOLOR: .quad 0xff007fff       # orange
    OBLOCKCOLOR: .quad 0xff00ffff       # yellow
    TBLOCKCOLOR: .quad 0xff800080       # purple
    SBLOCKCOLOR: .quad 0xff00ff00       # green
    ZBLOCKCOLOR: .quad 0xff0000ff       # red

    BACKGROUND: .quad 0xffab5e5b        # very light blue
    INFOSCREENBACKGROUND: .quad 0xff4a2723 # darker blue
    BORDERCOLOUR: .quad 0xff5c2c0e      # darkish blue
    NEXTBLOCKOUTLINECOLOR: .quad 0xff300e0a # dark blue
