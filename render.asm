#SECTION "RenderWRAM", WRAM0 {
wScreenScrollRange:
.xmin: ds 1
.xmax: ds 1
.ymin: ds 1
.ymax: ds 1
wScreenScrollTarget:
.x: ds 1
.y: ds 1

wOAMBuffer2:
    ds 40 * 4
.end:
wOAMBuffer2Index:
    ds 1
}


#SECTION "RenderCode", ROM0 {
DrawLevel:
    ; First load TID in BufferA, flags in BufferC (for priority) and direction in BufferB
    call ResetTileBufferA
    ld   hl, wTileBufferB
    ld   bc, wTileBufferC.end - wTileBufferB
    call clearMem
    ld   hl, wOAMBuffer2
    ld   bc, wOAMBuffer2.end - wOAMBuffer2
    call clearMem
    xor  a
    ld   [wOAMBuffer2Index], a

    ld   hl, wObjects.type
.objectLoop:
    ld   a, [hl]
    cp   $ff
    jp   z, .drawLevelTiles
    ld   b, a
    ld   c, FLAG_YOU - 1 ; Default flag for text objects
    cp   TID_IS
    jr   nc, .defaultObjectFlags
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    ld   c, a
.defaultObjectFlags:
    ; flags in c
    inc  h ; hl -> wObjects.yx
    ld   e, [hl]
    ld   d, HIGH(wTileBufferC)
    ld   a, [de]
    cp   c
    jr   z, .setVisibleTile
    jr   nc, .renderAsSprite
.setVisibleTile:
    call renderAddSpriteFromXY
    ld   a, c
    ld   [de], a
    dec  d  ; de = BufferB
    ld   h, HIGH(wObjects.dir)
    ld   a, [hl]
    ld   [de], a
    dec  d  ; de = BufferA
    ld   a, b ; object type
    ld   [de], a
.skipVisibleTile:
    ld   h, HIGH(wObjects.type)
    inc  l
    jr   .objectLoop
.renderAsSprite:
    call renderAddSpriteFromObjIdx
    jr   .skipVisibleTile

.drawLevelTiles:
    ; Start drawing the map to VRAM
    ld   de, $9800
    ld   hl, wTileBufferA
.drawTilesLoop:
    inc  h
    ld   a, [hl]    ; Get the direction from BufferB
    ldh  [hMultiPurpose0], a
    dec  h
    ld   a, [hl+]
    push hl
    push de
    ld   hl, MetaTileData
    ld   b, 0
    ld   c, a
    add  hl, bc
    add  hl, bc
    add  hl, bc
    call RenderTile
    pop  de
    pop  hl
    inc  de
    inc  de
    ld   a, e
    and  $1F
    jr   nz, .noNewRow
    ld   a, 32
    ADD16.A de
.noNewRow:
    ld   a, h
    cp   HIGH(wTileBufferB)
    jr   nz, .drawTilesLoop

SetupScreenScroll:
    ld   a, $FF
    ld   hl, wScreenScrollRange
    ld   [hl+], a ; .xmin
    inc  a ; a = $00
    ld   [hl+], a ; .xmax
    dec  a ; a = $FF
    ld   [hl+], a ; .ymin
    inc  a ; a = $00
    ld   [hl+], a ; .ymax
    ; Figure out the target screen X/Y offsets by looping over all YOU objects and record min/max range
    ld   hl, wObjects.type + $FF
.loop:
    inc  l
    ld   a, [hl]
    cp   TID_NO_OBJECT
    jr   z, .loopDone
    cp   TID_IS
    jr   nc, .loop
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    and  FLAG_YOU
    jr   z, .loop
    push hl
    ld   h, HIGH(wObjects.yx)
    ld   a, [hl]
    ld   c, a
    ld   hl, wScreenScrollRange.xmin
    and  $0F
    cp   [hl]
    jr   nc, .no_xmin
    ld   [hl], a
.no_xmin:
    inc  hl
    cp   [hl]
    jr   c, .no_xmax
    ld   [hl], a
.no_xmax:
    inc  hl

    ld   a, c
    swap a
    and  $0F
    cp   [hl]
    jr   nc, .no_ymin
    ld   [hl], a
.no_ymin:
    inc  hl
    cp   [hl]
    jr   c, .no_ymax
    ld   [hl], a
.no_ymax:

    pop  hl
    jr   .loop
.loopDone:

    ld   a, [wScreenScrollRange.xmax]
    ld   hl, wScreenScrollRange.xmin
    add  [hl]
    cp   $FF
    ret  z ; no YOU object
    rlca
    rlca
    rlca
    sub  80 - 8
    jr   nc, .no_x_zero
    xor  a
.no_x_zero:
    cp   256 - 160
    jr   c, .no_x_max_clamp
    ld   a, 256 - 160
.no_x_max_clamp:
    ld   [wScreenScrollTarget.x], a

    ld   a, [wScreenScrollRange.ymax]
    ld   hl, wScreenScrollRange.ymin
    add  [hl]
    rlca
    rlca
    rlca
    sub  72 - 8
    jr   nc, .no_y_zero
    xor  a
.no_y_zero:
    cp   256 - 144
    jr   c, .no_y_max_clamp
    ld   a, 256 - 144
.no_y_max_clamp:
    ld   [wScreenScrollTarget.y], a
    ret

RenderUpdateScreenScroll:
    ld   c, LOW(rSCX)
    ld   hl, wScreenScrollTarget.x
    call .doscroll
    ld   c, LOW(rSCY)
    ld   hl, wScreenScrollTarget.y
.doscroll:
    ldh  a, [c]
    cp   [hl]
    ret  z
    jr   nc, .dec
    add  4
    ldh  [c], a
    ret
.dec:
    sub  4
    ldh  [c], a
    ret

RenderUpdateOAM:
    ldh  a, [rSCX]
    ld   b, a
    ldh  a, [rSCY]
    ld   c, a
    ld   hl, wOAMBuffer2
    ld   de, wOAMBuffer

    ld   a, 40
.loop:
    push af
    ld   a, [hl+]
    sub  a, c
    ld   [de], a
    inc  de
    ld   a, [hl+]
    sub  a, b
    ld   [de], a
    inc  de
    ld   a, [hl+]
    ld   [de], a
    inc  de
    ld   a, [hl+]
    ld   [de], a
    inc  de
    pop  af
    dec  a
    jr   nz, .loop
    ret

; Render the metatile data from HL to VRAM at DE
RenderTile:
    ld   a, [hl+]
    and  a, a
    jr   z, RenderAllTheSameTile
    dec  a
    jr   z, RenderSimple4Tile
    dec  a
    jr   z, RenderDirectionalTile

RenderAllTheSameTile:
    push de
    ld   a, [hl+]
    call Write4TilesToVRAM
    pop  de
    jp   RenderTileAttr

RenderSimple4Tile:
    ld   a, [hl+]
.render4tiles:
    push de
    ld   c, a
    WAIT_STAT
    ld   a, c
    ld   [de], a
    inc  de
    inc  c
    WAIT_STAT
    ld   a, c
    ld   [de], a
    add  a, 16
    ld   c, a
    ld   a, 32
    ADD16.A de
    WAIT_STAT
    ld   a, c
    ld   [de], a
    dec  c
    dec  de
    WAIT_STAT
    ld   a, c
    ld   [de], a
    pop  de
    jr   RenderTileAttr

RenderDirectionalTile:
    ld   a, [hl+]
    ld   c, a
    ldh  a, [hMultiPurpose0]
    cp   DIR_RIGHT
    jr   z, .renderRight
    add  a, a
    add  a, c
    jr   RenderSimple4Tile.render4tiles

.renderRight: ; Special case for looking right, were we need to flip the tiles.
    add  a, a
    add  a, c
    dec  a

    push de
    ld   c, a
    WAIT_STAT
    ld   a, c
    ld   [de], a
    inc  de
    dec  c
    WAIT_STAT
    ld   a, c
    ld   [de], a
    add  a, 16
    ld   c, a
    ld   a, 32
    ADD16.A de
    WAIT_STAT
    ld   a, c
    ld   [de], a
    inc  c
    dec  de
    WAIT_STAT
    ld   a, c
    ld   [de], a
    pop  de

    ld   a, 1
    ldh  [rVBK], a
    ld   a, [hl+]
    or   a, $20
    call Write4TilesToVRAM ; Set bg attributes
    xor  a
    ldh  [rVBK], a
    ret

RenderTileAttr:
    ld   a, 1
    ldh  [rVBK], a
    ld   a, [hl+]
    call Write4TilesToVRAM ; Set bg attributes
    xor  a
    ldh  [rVBK], a
    ret

Write4TilesToVRAM:
    ld   c, a
    WAIT_STAT
    ld   a, c
    ld   [de], a
    inc  de
    WAIT_STAT
    ld   a, c
    ld   [de], a
    ld   a, 32
    ADD16.A de
    WAIT_STAT
    ld   a, c
    ld   [de], a
    dec  de
    WAIT_STAT
    ld   a, c
    ld   [de], a
    ret

; Add the graphics from the object at index L to the OAM buffer.
renderAddSpriteFromObjIdx:
    push de
    ld   h, HIGH(wObjects.type)
    ld   a, [hl]
    ldh  [hMultiPurpose1], a ; store TID
    ld   h, HIGH(wObjects.dir)
    ld   a, [hl]
    ldh  [hMultiPurpose0], a ; store direction
    ld   h, HIGH(wObjects.yx)
    ld   e, [hl]
    jr   renderAddSpriteFromXY.startRender

; Add the graphics from the tile at position E to the OAM buffer.
renderAddSpriteFromXY:
    push de
    ld   d, HIGH(wTileBufferA)
    ld   a, [de]
    cp   $FF ; no object, so nothing to do
    jp   z, .ret
    ldh  [hMultiPurpose1], a ; store TID
    inc  d ; HIGH(wTileBufferB)
    ld   a, [de]
    ldh  [hMultiPurpose0], a ; store direction
.startRender:
    ld   a, [wOAMBuffer2Index]
    cp   4 * 40
    jp   z, .ret
    push bc
    push hl

    ; Calculate OAM YX position and store in BC
    ld   a, e
    and  $F0
    add  $10
    ld   b, a
    ld   a, e
    and  $0F
    swap a
    add  8
    ld   c, a

    ; Get the TID to access MetaTileData
    ldh  a, [hMultiPurpose1]
    ld   e, a
    ld   d, 0
    ld   hl, MetaTileData
    add  hl, de
    add  hl, de
    add  hl, de

    ; Render type
    ld   a, [hl+]
    ldh  [hMultiPurpose2], a ; backup the render type
    ; Render tile and attr
    ld   a, [hl+]
    ld   e, a
    ld   d, [hl]
    set  7, d ; set BG priority bit
    ld   a, [wOAMBuffer2Index]
    LD16.ADD.A hl, wOAMBuffer2
    ld   a, [wOAMBuffer2Index]
    add  4 * 4
    ld   [wOAMBuffer2Index], a

    ; Now add the sprite to the buffer
    ; hl=buffer pointer
    ; de=tile nr+attr
    ; bc=yx
    ldh  a, [hMultiPurpose2]
    and  a, a
    jr   z, .renderAllTheSameSprite
    dec  a
    jr   z, .renderSimple4Sprite
    dec  a
    jp   z, .renderDirectionalSprite

.renderAllTheSameSprite:
    ld   a, b
    ld   [hl+], a
    ld   a, c
    ld   [hl+], a
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    ld   [hl+], a
    ld   a, c
    add  8
    ld   [hl+], a
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    add  8
    ld   [hl+], a
    ld   a, c
    ld   [hl+], a
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    add  8
    ld   [hl+], a
    ld   a, c
    add  8
    ld   [hl+], a
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    pop  hl
    pop  bc
.ret:
    pop  de
    ret

.renderSimple4Sprite:
    ld   a, b
    ld   [hl+], a
    ld   a, c
    ld   [hl+], a
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    ld   [hl+], a
    ld   a, c
    add  8
    ld   [hl+], a
    inc  e
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    add  8
    ld   [hl+], a
    ld   a, c
    ld   [hl+], a
    ld   a, e
    add  15
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    add  8
    ld   [hl+], a
    ld   a, c
    add  8
    ld   [hl+], a
    ld   a, e
    add  16
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    pop  hl
    pop  bc
    pop  de
    ret

.renderDirectionalSprite:
    ldh  a, [hMultiPurpose0] ; direction
    cp   DIR_RIGHT
    jr   z, .renderDirectionalSpriteRight
    add  a, a
    add  e
    ld   e, a
    jp   .renderSimple4Sprite
.renderDirectionalSpriteRight:
    ld   a, e
    add  a, 5
    ld   e, a
    set  5, d

    ld   a, b
    ld   [hl+], a
    ld   a, c
    ld   [hl+], a
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    ld   [hl+], a
    ld   a, c
    add  8
    ld   [hl+], a
    dec  e
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    add  8
    ld   [hl+], a
    ld   a, c
    ld   [hl+], a
    ld   a, e
    add  17
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    ld   a, b
    add  8
    ld   [hl+], a
    ld   a, c
    add  8
    ld   [hl+], a
    ld   a, e
    add  16
    ld   [hl+], a
    ld   a, d
    ld   [hl+], a

    pop  hl
    pop  bc
    pop  de
    ret
}