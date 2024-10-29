
#SECTION "ClearMem", ROM0 {
    ; Clear HL with the size of BC
clearMem:
    xor a
    ; Set HL with the size of BC to A
setMem:
    ; Apply some trickery to set bc in such a way that dec c/b works correctly
    inc b
    dec bc
    inc c
.loop:
    ld  [hl+], a
    dec c
    jr  nz, .loop
    dec b
    jr  nz, .loop
    ret
}


#SECTION "CopyData", ROM0 {
    ; Copy HL to DE with size of BC, requires bc!=00
copyData:
    ; Apply some trickery to set bc in such a way that dec c/b works correctly
    inc b
    dec bc
    inc c
.loop:
    ld  a, [hl+]
    ld  [de], a
    inc de
    dec c
    jr  nz, .loop
    dec b
    jr  nz, .loop
    ret
}

#MACRO LD16.ADD.A _reg, _target {
    add  a, LOW(_target)
    ld   LOW(_reg), a
    adc  HIGH(_target)
    sub  LOW(_reg)
    ld   HIGH(_reg), a
}
#MACRO ADD16.A _reg {
    add  a, LOW(_reg)
    ld   LOW(_reg), a
    adc  a, HIGH(_reg)
    sub  LOW(_reg)
    ld   HIGH(_reg), a
}
