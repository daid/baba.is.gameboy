#SECTION "Palette", ROMX, BANK[1] {

#MACRO RGB32 _rgb32 {
    dw (((_rgb32) >> 19) & $001F) | (((_rgb32) >> 6) & $03E0) | (((_rgb32) << 7) & $7C00)
}

#MACRO RGB32_4 _a, _b, _c, _d {
    RGB32 _a
    RGB32 _b
    RGB32 _c
    RGB32 _d
}

Palette:
    RGB32_4 0, $2D2922, $737373, $FEFEFE ; 0 black-white
    RGB32_4 0, $421910, $81261C, $E4533B ; 1 red
    RGB32_4 0, $303824, $5C8239, $B5D240 ; 2 green
    RGB32_4 0, $294890, $557ADF, $73AAF2 ; 3 blue
    RGB32_4 0, $682E4C, $D8396A, $EA90C9 ; 4 purple
    RGB32_4 0, $000000, $000000, $000000 ; 5
    RGB32_4 0, $503F24, $8F673E, $FEBC47 ; 6 brown/Yellow
    RGB32_4 0, $2F2B28, $10A840, $F8B888 ; 7
.end:

; $2D2922 $15181F $421910 $603980 $682E4C $303824 $503F24
; $737373 $293141 $81261C $8D5E9B $D8396A $4B5C1C $8F673E
; $C2C2C2 $3E7687 $E4533B $4759B0 $EA90C9 $5C8239 $C19D46
; $FEFEFE $5F9CD0 $E39850 $557ADF $294890 $A4B03F $2D2922
; $09090A $82C7E4 $ECE184 $FEBC47 $73AAF2 $B5D240 $09090A
}