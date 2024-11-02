#SECTION "MoveCode", ROM0 {

DoTurnYouStep: ; each object with YOU flag set, set the move counter += 1
    ld   hl, wObjects.type
    dec  l
.loop:
    inc  l
    ld   a, [hl]
    cp   $FF
    ret  z
    cp   TID_IS
    jr   nc, .loop
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    and  FLAG_YOU
    jr   z, .loop
    ld   h, HIGH(wObjects.dir)
    ldh  a, [hMultiPurpose0]
    ld   [hl], a
    ld   h, HIGH(wObjects.move)
    inc  [hl]
    ld   h, HIGH(wObjects.type)
    jr   .loop

DoMoveStep: ; each object with MOVE flag, set move counter += 1
    ld   hl, wObjects.type
    dec  l
.loop:
    inc  l
    ld   a, [hl]
    cp   $FF
    ret  z
    cp   TID_IS
    jr   nc, .loop
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    and  FLAG_MOVE
    jr   z, .loop
    ld   h, HIGH(wObjects.move)
    inc  [hl]
    ld   h, HIGH(wObjects.type)
    jr   .loop

DoTurnExecuteMoves:
    ld   l, $FF
.loop:
    ld   h, HIGH(wObjects.type)
    inc  l
    ld   a, [hl]
    cp   $FF
    ret  z
    ld   h, HIGH(wObjects.move)
    ld   a, [hl]
    and  a
    jr   z, .loop
    dec  [hl]
    ld   h, HIGH(wObjects.dir)
    ld   a, [hl]
    ldh  [hMultiPurpose0], a ; Store move dir in hMultiPurpose0
    call CanMove
    jr   z, .cannotMove ; cannot move
    call DoMove
    jr   .loop
.cannotMove:
    ; Check if this object is MOVE, if that is the case then flip the direction
    ld   h, HIGH(wObjects.type)
    ld   a, [hl]
    cp   TID_IS
    jr   nc, .loop
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    and  FLAG_MOVE
    jr   z, .loop
    ld   h, HIGH(wObjects.dir)
    ld   a, [hl]
    xor  1
    ld   [hl], a
    ld   h, HIGH(wObjects.move)
    inc  [hl] ; If we turn around, we try to make another step.
    jr   .loop

; check if the object L can move to direction hMultiPurpose0
;  z=cannot move
; nz=can move
CanMove:
    ld   h, HIGH(wObjects.yx)
    ld   c, [hl]
CanMoveFromXY: ; check if we can move from position C
    call ApplyMoveOffset
    ret  z
    ld   a, c
    ldh  [hMultiPurpose2], a
    xor  a
    ldh  [hMultiPurpose1], a
    ld   b, HIGH(wTileBufferA)
    ld   a, [bc]
    cp   $FF
    jr   z, .doneThisTile
    ld   c, a
.loop:
    ld   b, HIGH(wObjects.type)
    ld   a, [bc]
    cp   TID_IS
    jr   nc, .checkPush
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    bit  FLAGN_PUSH, a
    jr   nz, .checkPush
    bit  FLAGN_STOP, a
    jr   nz, .doneZ
    jr   .next
.checkPush:
    ld   a, 1
    ldh  [hMultiPurpose1], a
.next:
    ld   b, HIGH(wObjects.next)
    ld   a, [bc]
    cp   $FF
    jr   z, .doneThisTile
    ld   c, a
    jr   .loop

.doneThisTile:
    ldh  a, [hMultiPurpose1]
    dec  a
    ret  nz ; No needed to check next tile for push.
    ldh  a, [hMultiPurpose2]
    ld   c, a
    jr   CanMoveFromXY
.doneZ:
    cp a, a ; set zero flag
    ret

; move object L into direction hMultiPurpose0
DoMove:
    ld   h, HIGH(wObjects.yx)
    ld   c, [hl]
    call ApplyMoveOffset
    ld   h, HIGH(wObjects.yx)
    ld   [hl], c
.pushObjectsAtXY:
    xor  a
    ldh  [hMultiPurpose1], a
    ld   a, c
    ldh  [hMultiPurpose2], a
    ld   b, HIGH(wTileBufferA)
    ld   a, [bc]
    cp   $FF
    ret  z
    ld   c, a
.loop:
    ld   b, HIGH(wObjects.type)
    ld   a, [bc]
    cp   TID_IS
    jr   nc, .doPush
    LD16.ADD.A de, wObjectInfo.flags
    ld   a, [de]
    bit  FLAGN_PUSH, a
    jr   z, .next
.doPush:
    ld   a, 1
    ldh  [hMultiPurpose1], a
    push bc
    push hl
    ld   l, c
    ld   h, HIGH(wObjects.yx)
    ld   c, [hl]
    call ApplyMoveOffset
    ld   [hl], c
    inc  h ; HIGH(wObjects.dir)
    ld   a, [hMultiPurpose0]
    ld   [hl], a
    pop  hl
    pop  bc
.next:
    ld   b, HIGH(wObjects.next)
    ld   a, [bc]
    cp   $FF
    jr   z, .doneThisTile
    ld   c, a
    jr   .loop
.doneThisTile:
    ldh  a, [hMultiPurpose1]
    dec  a
    ret  nz ; No push done
    ldh  a, [hMultiPurpose2]
    ld   c, a
    call ApplyMoveOffset
    jr   .pushObjectsAtXY
    ret

; Offset the position in C with the direction in hMultiPurpose0
; z = move would have moved outside area
; nz = move done
ApplyMoveOffset:
    ldh  a, [hMultiPurpose0]
    and  a, a
    jr   z, .down
    dec  a
    jr   z, .up
    dec  a
    jr   z, .left
.right:
    ld   a, c
    and  $0F
    cp   $0F
    ret  z ; x == 15
    inc  c ; guaranteed zero flag clear
    ret
.left:
    ld   a, c
    and  $0F
    ret  z ; x == 0
    dec  c
    rra  ; clear zero flag
    ret
.up:
    ld   a, c
    and  $F0
    ret  z ; y == 0
    ld   a, c
    sub  $10
    ld   c, a
    rra  ; clear zero flag
    ret
.down:
    ld   a, c
    and  $F0
    cp   $F0
    ret  z ; y == 15
    ld   a, c
    add  a, $10  ; guaranteed zero flag clear
    ld   c, a
    ret
}