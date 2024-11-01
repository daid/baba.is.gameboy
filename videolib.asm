#MACRO WAIT_STAT {
    ldh  a, [rSTAT]
    and  $02
    db   $20, $FA ; jr nz, ...
}

#SECTION "VideoWRAM", WRAM0[$C000] {
wOAMBuffer:
    ds 40 * 4
.end:
}

#SECTION "VideoHRAM", HRAM {
hDMARoutine:
    ds 16
.end:

hVBlankCount: ds 1
hLagFrames: ds 1
}

#SECTION "VideoLib", ROM0 {

waitVBlank:
    ldh  a, [hVBlankCount]
    ldh  [hLagFrames], a
    xor  a
    ldh  [rIF], a
    halt
    ldh  [hVBlankCount], a
    ret

initVideo:
    ld  de, hDMARoutine
    ld  hl, DMARoutine
    ld  bc, DMARoutine.end - DMARoutine
    #ASSERT (hDMARoutine.end - hDMARoutine) >= (DMARoutine.end - DMARoutine)
    call copyData

    ; Enable the LCD and hide the window off-screen.
    ld   a, $F3
    ldh  [rLCDC], a
    ld   a, 7
    ldh  [rWX], a
    ld   a, 144
    ldh  [rWY], a

    ; Setup the vblank interrupt
    xor  a
    ldh  [rIF], a
    inc  a
    ldh  [rIE], a

    ; Finally enable interrupts
    ei

;   Set all background tiles to $00 and scroll registers to 0,0
clearBackground:
    ; Clear tiles to tile 0
    call .runClearLoop
    ; Clear attributes
    ld   a, 1
    ldh  [rVBK], a
    call .runClearLoop
    ld   a, 0
    ldh  [rVBK], a

    ld   hl, wOAMBuffer
    ld   bc, wOAMBuffer.end - wOAMBuffer
    call clearMem
    call hDMARoutine

    ldh  [rSCX], a
    ldh  [rSCY], a
    ret

.runClearLoop:
    ld   hl, $9800
    ld   bc, $0800
.loop:
    WAIT_STAT
    xor  a
    ld   [hl+], a
    dec  c
    jr   nz, .loop
    dec  b
    jr   nz, .loop
    ret

loadPal:
    ld  a, $80
    ldh [rBCPS], a
    ldh [rOCPS], a
    ld  c, 8 * 4 * 2
.loop:
    WAIT_STAT
    ld  a, [hl+]
    ldh [rBCPD], a
    ldh [rOCPD], a
    dec c
    jr  nz, .loop
    ret

DMARoutine:
    ; Initiate DMA
    ld   a, HIGH(wOAMBuffer)
    ldh  [rDMA], a
    ld   a, $28
.wait:
    dec  a
    jr   nz, .wait
    ret
.end:

;   Run C HDMA entries at HL, one entry per frame.
executeHDMAList:
.loop:
    ld   de, rHDMA1
    ld   b, 5
    call waitVBlank
.copyLoop:
    ld   a, [hl+]
    ld   [de], a
    inc  de
    dec  b
    jr   nz, .copyLoop
    dec  c
    jr   nz, .loop
    ret

}

#MACRO HDMA_LIST_ENTRY _label, _target, _tile_count {
    db   HIGH(_label), LOW(_label), HIGH(_target), LOW(_target), _tile_count - 1
}

#SECTION "VBlankISR", ROM0[$0040] {
    push af
    ldh  a, [hVBlankCount]
    inc  a
    ldh  [hVBlankCount], a
    pop  af
    reti
}
