.data
    romulusFontPath: .asciz "info_screen/resources/fonts/romulus.png"
    setbackFontPath: .asciz "info_screen/resources/fonts/setback.png"
    pixelplayFontPath: .asciz "info_screen/resources/fonts/pixelplay.png"
    pixantiquaFontPath: .asciz "info_screen/resources/fonts/pixantiqua.png"

.text

.macro setUpFont
    subq $80, %rsp                  
    leaq -160(%rbp), %rax

    movq $setbackFontPath, %rsi
    # movq %rdx, %rsi
    movq %rax, %rdi
    call LoadFont
.endm

.macro passFontArgument

.endm
