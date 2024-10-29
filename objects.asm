#SECTION "ObjectsWRAM", WRAM0 {
wObjectInfo:
.flags:     ds $40
.flags2:    ds $40
.transform: ds $40
.end:
}

#SECTION "ObjectsAlignedWRAM", WRAM0[$C100] {
wObjects:
.type:    ds 256
.yx:      ds 256
.dir:     ds 256
.move:    ds 256
.next:    ds 256
.end:

wTileBufferA:
    ds 16*16
.end:
wTileBufferB:
    ds 16*16
.end:
wTileBufferC:
    ds 16*16
.end:
}

#SECTION "ObjectUtils", ROM0 {
ResetTileBufferA:
    ld   a, $FF
    ld   hl, wTileBufferA
    ld   bc, wTileBufferA.end - wTileBufferA
    jr   setMem
}