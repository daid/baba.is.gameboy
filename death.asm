#SECTION "Death", ROM0 {

ProcessDeaths:
    ; object position cache should still be valid from rule update
    ; check for sink/defeat/hot rules that could kill other objects
    ld   l, $FF
.loop:
    ld   h, HIGH(wObjects.type)
    inc  l
    ld   a, [hl]
    cp   TID_NO_OBJECT
    jr   z, .done
    cp   TID_IS
    jr   nc, .loop
    LD16.ADD.A de, wObjectInfo.flags2
    ld   a, [de]
    ld   c, a
    bit  FLAG2N_SINK, c
    call nz, ProcessSink
    bit  FLAG2N_DEFEAT, c
    call nz, ProcessDefeat
    bit  FLAG2N_HOT, c
    call nz, ProcessHot
    jr   .loop

.done:
    ; Now, for all TID_DESTROYED objects, erase them from the list.
    ; We do this as last step to prevent invalidating the position cache during processing
    ld   e, l ; backup the pointer to the last entry.

    ld   hl, wObjects.type + $FF
.clearDeathLoop:
    inc  l
    ld   a, [hl]
    cp   $FF
    ret  z
    cp   TID_DESTROYED
    jr   nz, .clearDeathLoop
    ld   [hl], TID_NO_OBJECT
    dec  e
    ; Move E to L object and clear E so we keep a full list of active objects
    ld   d, HIGH(wObjects.type)
    ld   a, [de]
    ld   [hl], a
    ld   a, TID_NO_OBJECT
    ld   [de], a
    ld   d, HIGH(wObjects.yx)
    ld   h, HIGH(wObjects.yx)
    ld   a, [de]
    ld   [hl], a
    ld   d, HIGH(wObjects.dir)
    ld   h, HIGH(wObjects.dir)
    ld   a, [de]
    ld   [hl], a
    ld   h, HIGH(wObjects.type)
    dec  l
    jr   .clearDeathLoop

ProcessSink:
    ; If there are 2 objects on this tile, destroy L and another one.
    ld   h, HIGH(wObjects.yx)
    ld   e, [hl]
    ld   d, HIGH(wTileBufferA)
    ld   a, [de]
    cp   l  ; first object on tile is the sink object
    jr   nz, .noNext
    ld   e, a
    ld   d, HIGH(wObjects.next)
    ld   a, [de]
.noNext:
    cp   TID_NO_OBJECT ; no 2nd object
    ret  z
    ld   d, HIGH(wObjects.type)
    ld   e, a
    ld   a, TID_DESTROYED
    ld   [de], a
    ld   [hl], a
    ret

ProcessDefeat:
    ; For each object on tile of L, if they are YOU, destroy them.
    ld   h, HIGH(wObjects.yx)
    ld   e, [hl]
    push hl
    ld   d, HIGH(wTileBufferA)
    ld   a, [de]
    ld   l, a
.loop:
    ld   h, HIGH(wObjects.type)
    ld   a, [hl]
    cp   TID_IS
    jr   nc, .next
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    and  FLAG_YOU
    jr   z, .next
    ld   [hl], TID_DESTROYED
.next:
    ld   h, HIGH(wObjects.next)
    ld   l, [hl]
    ld   a, $FF
    cp   l
    jr   nz, .loop
    pop  hl
    ret

ProcessHot:
    ; For each object on tile of L, if they are MELT, destroy them.
    ld   h, HIGH(wObjects.yx)
    ld   e, [hl]
    push hl
    ld   d, HIGH(wTileBufferA)
    ld   a, [de]
    ld   l, a
.loop:
    ld   h, HIGH(wObjects.type)
    ld   a, [hl]
    cp   TID_IS
    jr   nc, .next
    LD16.ADD.A de, wObjectInfo.flags2
    ld   a, [de]
    and  FLAG2_MELT
    jr   z, .next
    ld   [hl], TID_DESTROYED
.next:
    ld   h, HIGH(wObjects.next)
    ld   l, [hl]
    ld   a, $FF
    cp   l
    jr   nz, .loop
    pop  hl
    ret
}