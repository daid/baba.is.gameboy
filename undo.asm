; Undo is stored in WRAM banks 2-7
; Note that this code cannot use the stack while the other wram bank is active.

#SECTION "UndoWRAM", WRAM0 {
wUndo:
.tailBank: ds 1
.headBank: ds 1
.writePtr: ds 2
.end:
}

#SECTION "UndoCode", ROM0 {

#ASSERT wObjects.end < $D000, "Objects need to be in the first WRAM area"
#ASSERT wUndo.end < $D000, "Undo WRAM needs to be in the first WRAM area"

; Hardcoded memory addresses for other WRAM banks.
wUndoPtrForBank = $D000
wUndoPtrStart = $D002
wUndoPtrEnd = $E000

ClearUndoList:
    ld   a, 2
    ld   [wUndo.tailBank], a
    ld   [wUndo.headBank], a
    ld   a, HIGH(wUndoPtrStart)
    ld   [wUndo.writePtr], a
    ld   a, LOW(wUndoPtrStart)
    ld   [wUndo.writePtr+1], a
    ret

AddUndoEntry:
    ld   hl, wObjects.type
.countObjectsLoop:
    ld   a, [hl+]
    cp   TID_NO_OBJECT
    jr   nz, .countObjectsLoop
    dec  l
    ret  z ; just skip if there are no objects
    ld   c, l ; amount of objects
    ld   h, $00
    ld   b, h
    ; Calculate how much size we need to store this undo entry (3x object count + 1 for amount of objects)
    add  hl, hl
    add  hl, bc
    ld   de, $0001
    add  hl, de
    ld   a, [wUndo.writePtr]
    ld   d, a
    ld   a, [wUndo.writePtr+1]
    ld   e, a
    add  hl, de ; end pointer after adding this entry
    ld   a, HIGH(wUndoPtrEnd)
    cp   h
    call c, .switchToNewBank
    call z, .switchToNewBank
    ; Start storing the undo data
    ld   a, [wUndo.headBank]
    ldh  [rSVBK], a
    ld   hl, wUndo.writePtr
    ld   a, [hl+]
    ld   e, [hl]
    ld   d, a
    ld   hl, wObjects.type
    ld   b, c ; backup the object count so we can use it 3 times
.copyTypes:
    ld  a, [hl+]
    ld  [de], a
    inc de
    dec c
    jr  nz, .copyTypes
    ld   hl, wObjects.yx
    ld   c, b
.copyYX:
    ld  a, [hl+]
    ld  [de], a
    inc de
    dec c
    jr  nz, .copyYX
    ld   hl, wObjects.dir
    ld   c, b
.copyDir:
    ld  a, [hl+]
    ld  [de], a
    inc de
    dec c
    jr  nz, .copyDir
    ld   a, b
    ld   [de], a ; store the amount of objects last
    inc  de
    xor  a
    ldh  [rSVBK], a
    ; finally store the pointer
    ld   a, d
    ld   [wUndo.writePtr], a
    ld   a, e
    ld   [wUndo.writePtr+1], a
    ret

.switchToNewBank:
    ; Switch the undo buffer to a new bank.
    ; First store the current pointer in the current bank.
    ld   a, [wUndo.headBank]
    ldh  [rSVBK], a
    ld   a, [wUndo.writePtr]
    ld   [wUndoPtrForBank], a
    ld   a, [wUndo.writePtr+1]
    ld   [wUndoPtrForBank+1], a
    xor  a
    ldh  [rSVBK], a
    ; Increase the bank nr and check if we meet the tail, if we do, move the tail to the next bank.
    ld   a, [wUndo.headBank]
    inc  a
    and  $07
    jr   nz, .no_bank_wrap
    ld   a, 2
.no_bank_wrap:
    ld   [wUndo.headBank], a
    ld   e, a
    ld   a, [wUndo.tailBank]
    cp   e
    jr   nz, .no_tail_move
    inc  a
    and  $07
    jr   nz, .no_bank_wrap_tail
    ld   a, 2
.no_bank_wrap_tail:
    ld   [wUndo.tailBank], a
.no_tail_move:
    ; Reset the pointer
    ld   a, HIGH(wUndoPtrStart)
    ld   [wUndo.writePtr], a
    ld   a, LOW(wUndoPtrStart)
    ld   [wUndo.writePtr+1], a
    ret

DoUndo:
    ld   a, [wUndo.writePtr]
    ld   h, a
    ld   a, [wUndo.writePtr+1]
    ld   l, a
    cp   LOW(wUndoPtrStart)
    jr   nz, .start
    ld   a, h
    cp   HIGH(wUndoPtrStart)
    jr   nz, .start
    ; Undo pointer is at the start of the WRAM bank.
    ld   a, [wUndo.headBank]
    ld   hl, wUndo.tailBank
    cp   [hl]
    ret  z ; No more undo to do
    dec  a
    cp   1
    jr   nz, .bank_nr_no_wrap
    ld   a, 7
.bank_nr_no_wrap:
    ld   [wUndo.headBank], a
    ldh  [rSVBK], a
    ld   a, [wUndoPtrForBank]
    ld   h, a
    ld   a, [wUndoPtrForBank+1]
    ld   l, a

.start:
    ld   a, [wUndo.headBank]
    ldh  [rSVBK], a
    ; hl is after the undo entry, [hl-1] = amount of objects
    dec  hl
    ld   a, [hl-]
    ld   b, a

    ld   c, b
    ld   d, HIGH(wObjects.dir)
    ld   e, c
.copyDirLoop:
    dec  e
    ld   a, [hl-]
    ld   [de], a
    dec  c
    jr   nz, .copyDirLoop

    ld   c, b
    ld   d, HIGH(wObjects.yx)
    ld   e, c
.copyYXLoop:
    dec  e
    ld   a, [hl-]
    ld   [de], a
    dec  c
    jr   nz, .copyYXLoop

    ld   c, b
    ld   d, HIGH(wObjects.type)
    ld   e, c
.copyTypeLoop:
    dec  e
    ld   a, [hl-]
    ld   [de], a
    dec  c
    jr   nz, .copyTypeLoop
    ld   e, b
    ld   a, TID_NO_OBJECT
    ld   [de], a

    xor  a
    ldh  [rSVBK], a

    inc  hl
    ld   a, h
    ld   [wUndo.writePtr], a
    ld   a, l
    ld   [wUndo.writePtr+1], a
    ret
}
