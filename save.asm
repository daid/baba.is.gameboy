
#SECTION "SRAM", SRAM {
sSaveValid:
    ds 2
sSaveLevelCleared:
    ds $100
.end:
}

#SECTION "InitSave", ROMX {
initSaveData:
    ; Check if the first 2 saved bytes are BABA, if not, initialize the save ram.
    ld   a, $BA
    ld   hl, sSaveValid
    cp   [hl]
    jr   nz, .init
    inc  hl
    cp   [hl]
    ret  z

.init:
    ld   a, $BA
    ld   hl, sSaveValid
    ld   [hl+], a
    ld   [hl+], a

    ld   hl, sSaveLevelCleared
    ld   bc, sSaveLevelCleared.end - sSaveLevelCleared
    call clearMem
    ret
}
