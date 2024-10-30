#INCLUDE "gbz80/all.asm"
#INCLUDE "stdlib.asm"
#INCLUDE "consts.asm"
#INCLUDE "input.asm"
#INCLUDE "videolib.asm"
#INCLUDE "palette.asm"
#INCLUDE "save.asm"
#INCLUDE "game.asm"
#INCLUDE "death.asm"
#INCLUDE "move.asm"
#INCLUDE "objects.asm"
#INCLUDE "rules.asm"
#INCLUDE "map.asm"
#INCLUDE "levels.asm"
#INCLUDE "levelselect.asm"
#INCLUDE "render.asm"
#INCLUDE "undo.asm"
#INCLUDE "objectmetadata.asm"


GBC_HEADER "Baba", 0, entry


#SECTION "Entry", ROMX, BANK[1] {
entry:
    ld sp, $E000

    ; enable SRAM
    xor  a
    ld   [$4000], a
    ld   a, $0A
    ld   [$0000], a

    call initSaveData

    xor  a
    ld   [wCurrentLevelIndex], a

    call initVideo
    ;call audioInit
    ld   hl, Palette
    call loadPal

    ; Disable interrupts and setup the VBlank interrupt to set IF
    di
    ld   a, 1
    ldh  [rIE], a

    ld   a, [sSaveLevelCleared]
    and  a, a
    jp   z, RunGame ; If we never finished the first level, jump right in.
    ;TODO jp   LevelSelect
}

#SECTION "WRAM", WRAM0 {
wCurrentLevelIndex:
    ds 1
}

#SECTION "HRAM", HRAM {
hMultiPurpose0:
    ds 1
hMultiPurpose1:
    ds 1
hMultiPurpose2:
    ds 1
}