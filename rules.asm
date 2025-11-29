#SECTION "Rules", ROM0 {
ProcessRules:
    call BuildObjectPositionCache
    ld   hl, wObjectInfo
    ld   bc, wObjectInfo.transform - wObjectInfo
    call clearMem
    ld   bc, wObjectInfo.end - wObjectInfo.transform
    ld   a, $FF
    call setMem

    ; for each object, check if TID_IS, then figure out the rule.
    ld   hl, wObjects.type
    dec  hl
.searchISLoop:
    inc  hl
    ld   a, [hl]
    cp   $FF
    ret  z
    cp   TID_IS
    jr   nz, .searchISLoop
    ; found an IS, find objects left and right of it and apply that rule.
    inc  h ; HIGH(wObjects.yx)
    ld   a, [hl]
    push hl ; (save object index for next iteration)
    ld   h, HIGH(wTileBufferA)
    ld   l, a ; l = YX
    push hl ; wTileBufferA[YX] (save YX position for vertical use)
    and  $0F
    dec  a
    cp   15
    jr   nc, .skipHorizontal
    dec  l
    ld   a, [hl] ; obj index of left tile
    inc  l
    inc  l
    ld   e, [hl] ; obj index of right tile
    call ApplyRuleStep1
.skipHorizontal:
    ; Now check what objects we have above/below
    pop  hl ; wTileBufferA[YX]
    ld   a, l
    and  $F0
    sub  $10
    cp   15 << 4
    jr   nc, .skipVertical
    ld   de, $10000 - $0010
    add  hl, de
    ld   a, [hl] ; obj index of up tile
    ld   de, $20
    add  hl, de
    ld   e, [hl]
    call ApplyRuleStep1
.skipVertical:
    pop  hl
    ld   h, HIGH(wObjects.type)
    jr   .searchISLoop

; Apply rules of [left] is [right].
; This accounts for stacked objects on [left] or [right] by using wObjects.next
; a = obj index of left object
; e = obj index of right object
ApplyRuleStep1:
    cp   $FF
    ret  z
    ld   b, HIGH(wObjects.type)
    ld   c, a
    ld   a, [bc]
    ld   h, a ; store left TID
    ld   l, e ; backup first right side index
.rightSideLoop:
    ld   a, e
    cp   $FF
    jr   z, .rightSideDone
    ld   d, HIGH(wObjects.type)
    ld   a, [de]
    push bc
    push de
    push hl
    call ApplyRuleStep2
    pop  hl
    pop  de
    pop  bc
    ld   d, HIGH(wObjects.next)
    ld   a, [de]
    ld   e, a
    jr   .rightSideLoop
.rightSideDone:
    ld   e, l ; restore right side index
    ld   b, HIGH(wObjects.next)
    ld   a, [bc]
    jr   ApplyRuleStep1

; a = right TID
; h = left TID
ApplyRuleStep2:
    bit 7, a
    ret z   ; left side isn't text
    bit 7, h
    ret z   ; right side isn't text
    bit 6, h
    ret nz  ; left side is a property
    cp  TID_PROP
    jr  c, .transform
    ld  c, a
    ld  a, h
    and TID_OBJ_MASK
    LD16.ADD.A hl, wObjectInfo.flags
    ld  a, c
    cp  TID_YOU
    jr  z, .you
    cp  TID_WIN
    jr  z, .win
    cp  TID_STOP
    jr  z, .stop
    cp  TID_SINK
    jr  z, .sink
    cp  TID_DEFEAT
    jr  z, .defeat
    cp  TID_HOT
    jr  z, .hot
    cp  TID_MELT
    jr  z, .melt
    cp  TID_PUSH
    jr  z, .push
    cp  TID_MOVE
    jr  z, .move
    ret
.you:
    set FLAGN_YOU, [hl]
    ret
.win:
    set FLAGN_WIN, [hl]
    ret
.stop:
    set FLAGN_STOP, [hl]
    ret
.sink:
    ld  de, wObjectInfo.flags2 - wObjectInfo.flags
    add hl, de
    set FLAG2N_SINK, [hl]
    ret
.defeat:
    ld  de, wObjectInfo.flags2 - wObjectInfo.flags
    add hl, de
    set FLAG2N_DEFEAT, [hl]
    ret
.hot:
    ld  de, wObjectInfo.flags2 - wObjectInfo.flags
    add hl, de
    set FLAG2N_HOT, [hl]
    ret
.melt:
    ld  de, wObjectInfo.flags2 - wObjectInfo.flags
    add hl, de
    set FLAG2N_MELT, [hl]
    ret
.push:
    set FLAGN_PUSH, [hl]
    ret
.move:
    set FLAGN_MOVE, [hl]
    ret
.transform:
    and TID_OBJ_MASK
    ld  c, a
    ld  a, h
    and TID_OBJ_MASK
    LD16.ADD.A de, wObjectInfo.transform
    ld  a, [de]
    or  TID_TEXT
    cp  h
    ret z ; X = X is active
    ld  a, c
    ld  [de], a ; wObjectInfo.transform[left] = right
    ret
}