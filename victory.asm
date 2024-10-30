#SECTION "VictoryCode", ROM0 {

victoryTiles:
    db $E0, $E1, $20, $21, $E2, $E3
    db $F0, $F1, $30, $31, $F2, $F3

; Do the victory animation and return to level select
victoryAnimation:
    ld   hl, wOAMBuffer
    ld   bc, wOAMBuffer.end - wOAMBuffer
    call clearMem
    call waitVBlank
    call hDMARoutine
    ld  a, 144
    ldh [rWY], a

    xor a
    ld  hl, $9C00
    ld  c, $40
.clearWindow:
    ld  [hl+], a
    ld  [hl+], a
    ld  [hl+], a
    ld  [hl+], a
    ld  [hl+], a
    ld  [hl+], a
    ld  [hl+], a
    ld  [hl+], a
    dec c
    jr  nz, .clearWindow
    ld  de, $9C47
    ld  hl, victoryTiles
    ld  bc, 6
    call copyData
    ld  de, $9C67
    ld  bc, 6
    call copyData

.scrollUp:
    call waitVBlank
    ldh a, [rWY]
    sub 4
    ldh [rWY], a
    jr nz, .scrollUp

    ld  a, 60
.wait:
    push af
    call waitVBlank
    call updateJoypadState
    ;TODO call audioUpdate
    pop  af
    dec  a
    jr   nz, .wait

    ld   a, [wCurrentLevelIndex]
    LD16.ADD.A hl, sSaveLevelCleared
    ld   a, 1
    ld   [hl], a

    jp   LevelSelect
}