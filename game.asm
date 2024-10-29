#SECTION "GameWRAM", WRAM0 {
wWinLevel:
    ds 1
}

#SECTION "Game", ROM0 {

GameHDMALines:
;    HDMA_LIST_ENTRY GameGraphics, $8000, 128
;    HDMA_LIST_ENTRY GameGraphics + $800, $8800, 128

RunGame:
    ld   a, [wCurrentLevelIndex]
    ld   h, 0
    ld   l, a
    add  hl, hl
    add  hl, hl
    ld   de, LevelTable + 2
    add  hl, de
    ld   a, [hl+]
    ld   h, [hl]
    ld   l, a
    call LoadLevel

    call clearBackground
    xor  a
    ldh  [rWY], a
    ld   hl, GameHDMALines
    ld   c, 2
    call executeHDMAList

    call ProcessRules
    call DrawLevel
    ld   a, [wScreenScrollTarget.x]
    ldh  [rSCX], a
    ld   a, [wScreenScrollTarget.y]
    ldh  [rSCY], a
    ld   a, 144
    ldh  [rWY], a

.loop:
    ld   a, [wWinLevel]
    and  a, a
    ;TODO jp   nz, victoryAnimation

    call waitVBlank
    call RenderUpdateScreenScroll
    call RenderUpdateOAM
    call hDMARoutine
    call updateJoypadState
    ;TODO call audioUpdate
    ld   a, [wJoypadPressed]
    cp   PADF_DOWN
    jr   z, .playerDown
    cp   PADF_UP
    jr   z, .playerUp
    cp   PADF_LEFT
    jr   z, .playerLeft
    cp   PADF_RIGHT
    jr   z, .playerRight
    cp   PADF_B
    jr   z, .playerSkip
    cp   PADF_A
    jr   z, .playerUndo
    cp   PADF_START
    ;TODO jp   z, LevelSelect

    ; Handle reset
    ld   a, [wJoypadPressed]
    and  PADF_A | PADF_B
    jr   z, .noReset
    ld   a, [wJoypadState]
    and  PADF_A | PADF_B
    cp   PADF_A | PADF_B
    jp   z, RunGame
.noReset:

    jr  .loop

.playerDown:
    ld   a, DIR_DOWN
    ldh  [hMultiPurpose0], a    ; store requested move direction
    call DoTurn
    jr   .loop
.playerUp:
    ld   a, DIR_UP
    ldh  [hMultiPurpose0], a    ; store requested move direction
    call DoTurn
    jr   .loop
.playerLeft:
    ld   a, DIR_LEFT
    ldh  [hMultiPurpose0], a    ; store requested move direction
    call DoTurn
    jr   .loop
.playerRight:
    ld   a, DIR_RIGHT
    ldh  [hMultiPurpose0], a    ; store requested move direction
    call DoTurn
    jp   .loop
.playerSkip:
    ld   a, DIR_NONE
    ldh  [hMultiPurpose0], a    ; store requested move direction
    call DoTurn
    jp   .loop
.playerUndo:
    ;TODO call DoUndo
    call ProcessRules
    call DrawLevel
    jp   .loop

DoTurn:
    ;TODO call AddUndoEntry
    call ProcessRules
    ldh  a, [hMultiPurpose0]
    inc  a
    ;TODO call nz, DoTurnYouStep
    ;TODO call DoMoveStep
    ;TODO call DoTurnExecuteMoves
    call BuildObjectPositionCache
    ;TODO call DoTurnExecuteMoves
    call ProcessRules
    call ProcessTransforms
    ;TODO call ProcessDeaths
    call CheckForWin
    call DrawLevel
    ret

CheckForWin:
    xor  a
    ld   [wWinLevel], a
    call BuildObjectPositionCache
    ld   l, $FF
.loop:
    ld   h, HIGH(wObjects.type)
    inc  l
    ld   a, [hl]
    cp   TID_NO_OBJECT
    ret  z
    cp   TID_IS
    jr   nc, .loop
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    and  a, FLAG_YOU
    jr   z, .loop
    ; you object find, check if there is a WIN object here as well
    ld   h, HIGH(wObjects.yx)
    ld   c, [hl]
    ld   b, HIGH(wTileBufferA)
    ld   a, [bc]
    ld   c, a
.loop2:
    ld   b, HIGH(wObjects.type)
    ld   a, [bc]
    cp   TID_IS
    jr   nc, .next
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    and  a, FLAG_WIN
    jr   z, .next
    ld   a, 1
    ld   [wWinLevel], a
.next:
    ld   b, HIGH(wObjects.next)
    ld   a, [bc]
    cp   a, $FF
    jr   z, .loop
    ld   c, a
    jr   .loop2

LoadLevel:
    ;TODO call ClearUndoList
    xor  a
    ld   [wWinLevel], a
    ld   de, wObjects.type
.loop:
    ld   c, DIR_RIGHT
    ld   a, [hl+]; get type
    ld   [de], a ; store type
    cp   $FF
    ret  z
    cp   $F0
    call nc, .handleDirection
    ld   a, [hl+]; get YX
    inc  d ; HIGH(wObjects.yx)
    ld   [de], a ; store yx
    ld   a, c
    inc  d ; HIGH(wObjects.dir)
    ld   [de], a ; store dir
    ld   d, HIGH(wObjects.type)
    inc  e
    jr   .loop
.handleDirection:
    and  $0F
    ld   c, a
    ld   a, [hl+]
    ld   [de], a
    ret

ProcessTransforms:
    ld   hl, wObjects.type + $FF
.loop:
    inc  l
    ld   a, [hl]
    cp   TID_NO_OBJECT
    ret  z
    cp   TID_IS
    jr   nc, .loop
    LD16.ADD.A de, wObjectInfo.transform
    ld   a, [de]
    cp   TID_NO_OBJECT
    jr   z, .loop
    ld   [hl], a
    jr   .loop


BuildObjectPositionCache:
    ; Set TileBufferA to which object index is on that tile.
    ;   Multiple objects are linked with the wObjects.next.
    call ResetTileBufferA
    ld   hl, wObjects.type
.objectLoop:
    ld   a, [hl]
    cp   $ff
    ret  z

    inc  h ; HIGH(wObjects.yx)
    ld   e, [hl]
    ld   d, HIGH(wTileBufferA)
    ld   a, [de]
    ld   h, HIGH(wObjects.next)
    ld   [hl], a
    ld   a, l
    ld   [de], a

    ld   h, HIGH(wObjects.type)
    inc  l
    jr   .objectLoop
}

#SECTION "GameGFX", ROMX[$4000], BANK[1] {
GameGraphics:
;TODO #INCGFX "baba.png"
}