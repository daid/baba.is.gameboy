#SECTION "LevelSelectGFX", ROMX[$5000], BANK[1] {
LevelSelectGraphics:
#INCGFX "baba_font.png"
}

#SECTION "LevelSelectWRAM", WRAM0 {
wMapPosX: ds 1
wMapPosY: ds 1
}

#SECTION "LevelSelectCode", ROMX, BANK[1] {

LevelSelectHDMALines:
    HDMA_LIST_ENTRY LevelSelectGraphics, $8000, 128

LevelSelect:
    call clearBackground
    ld   hl, LevelSelectHDMALines
    ld   c, 1
    call executeHDMAList
    call BuildLevelMap
    call DrawLevelMap

    ld   hl, $9C00
    ld   c, 20
.windowLineLoop:
    WAIT_STAT
    ld   a, $60
    ld   [hl+], a
    dec  c
    jr   nz, .windowLineLoop

.updateWindow:
    ld   a, 144 - 24
    ldh  [rWY], a

    ld   hl, $9C20
    ld   c, 20
.clearNameLoop:
    WAIT_STAT
    xor  a
    ld   [hl+], a
    dec  c
    jr   nz, .clearNameLoop
    call getMapCellContent
    ld   a, b
    cp   $F0
    jr   nc, .loop

    ld   h, 0
    ld   l, a
    add  hl, hl
    add  hl, hl
    ld   de, LevelTable
    add  hl, de
    ld   a, [hl+]
    ld   h, [hl]
    ld   l, a ; pointer to name in hl

    ld   de, $9C20
.drawNameLoop:
    WAIT_STAT
    ld   a, [hl+]
    sub  $20
    jr   c, .loop
    ld   [de], a
    inc  de
    jr   .drawNameLoop

.loop:
    ; Setup cursor sprites
    ld   a, [wMapPosX]
    rlca
    rlca
    rlca
    add  4
    ld   b, a
    ld   a, [wMapPosY]
    rlca
    rlca
    rlca
    add  12
    ld   c, a

    ld   hl, wOAMBuffer
    ld   a, c
    ld   [hl+], a
    ld   a, b
    ld   [hl+], a
    ld   a, $70
    ld   [hl+], a
    ld   a, $02
    ld   [hl+], a
    ld   a, c
    add  8
    ld   [hl+], a
    ld   a, b
    ld   [hl+], a
    ld   a, $70
    ld   [hl+], a
    ld   a, $42
    ld   [hl+], a

    ld   a, c
    ld   [hl+], a
    ld   a, b
    add  8
    ld   [hl+], a
    ld   a, $70
    ld   [hl+], a
    ld   a, $22
    ld   [hl+], a
    ld   a, c
    add  8
    ld   [hl+], a
    ld   a, b
    add  8
    ld   [hl+], a
    ld   a, $70
    ld   [hl+], a
    ld   a, $62
    ld   [hl+], a

    call waitVBlank
    call hDMARoutine
    call updateJoypadState
    ; TODO call audioUpdate

    ld   a, [wJoypadPressed]
    cp   PADF_DOWN
    jr   z, .playerDown
    cp   PADF_UP
    jr   z, .playerUp
    cp   PADF_LEFT
    jr   z, .playerLeft
    cp   PADF_RIGHT
    jr   z, .playerRight
    cp   PADF_A
    jr   z, .selectLevel
    jr   .loop
.playerDown:
    ld   bc, $0001
    jr   .moveCursor
.playerUp:
    ld   bc, $00FF
    jr   .moveCursor
.playerLeft:
    ld   bc, $FF00
    jr   .moveCursor
.playerRight:
    ld   bc, $0100
.moveCursor:
    ld   hl, wMapPosX
    ld   a, [hl]
    add  b
    ld   [hl+], a
    ld   a, [hl]
    add  c
    ld   [hl], a
    push bc
    call getMapCellContent
    pop  bc
    and  a
    jp   nz, .updateWindow
    ld   hl, wMapPosX
    ld   a, [hl]
    sub  b
    ld   [hl+], a
    ld   a, [hl]
    sub  c
    ld   [hl], a
    jp   .loop
.selectLevel:
    call getMapCellContent
    ld   a, b
    cp   $F0
    jp   nc, .loop ; on a path
    ld   [wCurrentLevelIndex], a
    jp   RunGame
    jp   .loop

; returns visual type in a and level number/path type in b
getMapCellContent:
    ld   a, [wMapPosY]
    ld   l, 0
    srl  a
    rr   l
    srl  a
    rr   l
    srl  a
    rr   l
    ld   h, a
    ld   a, [wMapPosX]
    or   l
    ld   l, a
    ld   de, LevelMap
    push hl
    add  hl, de
    ld   a, [hl]
    ld   b, a
    pop  hl
    ld   de, wObjects
    add  hl, de
    ld   a, [hl]
    ret

; use wObjects data block to store current level map
BuildLevelMap:
    ld   hl, wObjects
    ld   bc, $0400
    call clearMem

    ld   de, LevelMap
    ld   bc, $0400
.findLevelsLoop:
    ld   a, [de]
    cp   $F0 ; check if it is a level
    jr   nc, .nextCell
    ld   hl, wCurrentLevelIndex
    push af
    cp   [hl]
    call z, .setMapCursorPos
    pop  af
    LD16.ADD.A hl, sSaveLevelCleared
    ld   a, [hl]
    and  a, a
    jr   z, .nextCell ; level not cleared
    call addMapTile
.nextCell:
    inc  de
    dec  c
    jr   nz, .findLevelsLoop
    dec  b
    jr   nz, .findLevelsLoop
    ret

.setMapCursorPos:
    ld   hl, $10000 - LevelMap
    add  hl, de
    ld   a, l
    and  $1F
    ld   [wMapPosX], a
    ld   a, l
    rlc  l
    rl   h
    rlc  l
    rl   h
    rlc  l
    rl   h
    ld   a, h
    and  $1F
    ld   [wMapPosY], a
    ret

; Add the map tile from the level map at DE to the "wObjects" map
; Recursive add things next to it.
addMapTile:
    ld   hl, wObjects - LevelMap
    add  hl, de
    ld   a, [hl]
    and  a, a
    ret  nz ; Tile already set
    ld   a, [de]
    cp   $FF
    ret  z
    cp   $F0
    jr   c, .level
    sub  $F0 - 3
    ld   [hl], a
    jr   .recurse
.level:
    push hl
    LD16.ADD.A hl, sSaveLevelCleared
    ld   a, [hl]
    pop  hl
    inc  a
    ld   [hl], a
    cp   $01
    ret  z
.recurse:
    push de
    inc  de
    call addMapTile
    pop  de
    push de
    dec  de
    call addMapTile
    pop  de
    push de
    ld   a, $20
    add  e
    ld   e, a
    adc  d
    sub  e
    ld   d, a
    call addMapTile
    pop  de
    ld   a, e
    sub  $20
    ld   e, a
    ld   a, d
    sbc  $00
    ld   d, a
    call addMapTile
    ret

DrawLevelMap:
    ld   hl, wObjects
    ld   de, $9800
    ld   bc, $0400
.loop:
    ld   a, [hl+]
    and  a, a
    jr   z, .next
    add  $60
    push af
    WAIT_STAT
    pop  af
    ld   [de], a
.next:
    inc  de
    dec  c
    jr   nz, .loop
    dec  b
    jr   nz, .loop
    ret
}