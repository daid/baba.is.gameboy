#SECTION "Levels", ROMX, BANK[1] {

#MACRO LEVEL_ROW _name, _data {
    dw 0, _data
}

LevelTable:
    LEVEL_ROW "0: LINK IS YOU", Level0
    LEVEL_ROW "1: Press A to UNDO", Level1
    LEVEL_ROW "2: A&B is RESET", Level2
    LEVEL_ROW "3: Out of reach", Level3
    LEVEL_ROW "4: More out of reach", Level4
    LEVEL_ROW "5: BABA", Level5
    LEVEL_ROW "6: Volcano", Level6
    LEVEL_ROW "7: Affection", Level7
    LEVEL_ROW "8: The wall", Level8
    LEVEL_ROW "Bonus: Prison", Level8Bonus
    LEVEL_ROW "9: Changeless", Level9
    LEVEL_ROW "Bonus: Ruins", Level9Bonus
    LEVEL_ROW "10: Love letter", Level10
    LEVEL_ROW "11: Teamwork", Level11
    LEVEL_ROW "12: Thief!", Level12
    LEVEL_ROW "13: Wireless", Level13
    LEVEL_ROW "14: The end.", Level14

TestLevelData:
    db   TID_BABA | TID_TEXT, $11
    db   TID_IS, $12
    db   TID_YOU, $13
    db   TID_WALL | TID_TEXT, $21
    db   TID_IS, $22
    db   TID_WIN, $23
    db   TID_KEKE, $28
    db   $F2, TID_KEKE, $29
    db   TID_BABA, $40
    db   TID_FLAG, $41
    db   TID_WALL, $42
    db   TID_ROCK, $43
    db   TID_WATR, $44
    db   TID_SKUL, $45
    db   TID_LAVA, $46
    db   TID_LINK, $47
    db   TID_KEKE, $48
    db   TID_LOVE, $49
    db   TID_BABA | TID_TEXT, $50
    db   TID_FLAG | TID_TEXT, $51
    db   TID_WALL | TID_TEXT, $52
    db   TID_ROCK | TID_TEXT, $53
    db   TID_WATR | TID_TEXT, $54
    db   TID_SKUL | TID_TEXT, $55
    db   TID_LAVA | TID_TEXT, $56
    db   TID_LINK | TID_TEXT, $57
    db   TID_KEKE | TID_TEXT, $58
    db   TID_LOVE | TID_TEXT, $59
    db   TID_YOU, $60
    db   TID_WIN, $61
    db   TID_STOP, $62
    db   TID_PUSH, $63
    db   TID_SINK, $64
    db   TID_DEFEAT, $65
    db   TID_HOT, $66
    db   TID_MELT, $67
    db   TID_MOVE, $68
    db   TID_FLAG, $28
    db   TID_FLAG, $29
    db   $FF

Level0:
    db   TID_LINK | TID_TEXT, $34
    db   TID_IS, $35
    db   TID_YOU, $36
    db   TID_FLAG | TID_TEXT, $39
    db   TID_IS, $3A
    db   TID_WIN, $3B
    db   TID_WALL, $52
    db   TID_WALL, $53
    db   TID_WALL, $54
    db   TID_WALL, $55
    db   TID_WALL, $56
    db   TID_WALL, $57
    db   TID_WALL, $58
    db   TID_WALL, $59
    db   TID_WALL, $5A
    db   TID_WALL, $5B
    db   TID_WALL, $5C
    db   TID_WALL, $5D
    db   TID_ROCK, $67
    db   TID_LINK, $75
    db   TID_ROCK, $77
    db   TID_FLAG, $7A
    db   TID_ROCK, $87
    db   TID_WALL, $92
    db   TID_WALL, $93
    db   TID_WALL, $94
    db   TID_WALL, $95
    db   TID_WALL, $96
    db   TID_WALL, $97
    db   TID_WALL, $98
    db   TID_WALL, $99
    db   TID_WALL, $9A
    db   TID_WALL, $9B
    db   TID_WALL, $9C
    db   TID_WALL, $9D
    db   TID_ROCK | TID_TEXT, $B4
    db   TID_IS, $B5
    db   TID_PUSH, $B6
    db   TID_WALL | TID_TEXT, $B9
    db   TID_IS, $BA
    db   TID_STOP, $BB
    db   $FF

Level1:
    db   TID_WALL, $16
    db   TID_WALL, $17
    db   TID_WALL, $18
    db   TID_WALL, $19
    db   TID_WALL, $1A
    db   TID_WALL, $1B
    db   TID_WALL, $1C
    db   TID_WALL, $26
    db   TID_WALL, $2C
    db   TID_WALL, $33
    db   TID_WALL, $34
    db   TID_WALL, $35
    db   TID_WALL, $36
    db   TID_IS, $38
    db   TID_WIN, $3A
    db   TID_WALL, $3C
    db   TID_WALL, $43
    db   TID_WALL, $4C
    db   TID_WALL, $53
    db   TID_FLAG | TID_TEXT, $55
    db   TID_FLAG, $59
    db   TID_WALL, $5C
    db   TID_WALL, $63
    db   TID_WALL, $6C
    db   TID_WALL, $73
    db   TID_WALL, $74
    db   TID_WALL, $75
    db   TID_WALL, $76
    db   TID_WALL, $77
    db   TID_WALL, $78
    db   TID_WALL, $79
    db   TID_WALL, $7A
    db   TID_WALL, $7B
    db   TID_WALL, $7C
    db   TID_WALL, $7D
    db   TID_WALL, $86
    db   TID_WALL, $8D
    db   TID_LINK | TID_TEXT, $94
    db   TID_WALL, $96
    db   TID_WALL | TID_TEXT, $98
    db   TID_LINK, $9A
    db   TID_WALL, $9D
    db   TID_IS, $A4
    db   TID_WALL, $A6
    db   TID_IS, $A8
    db   TID_WALL, $AD
    db   TID_YOU, $B4
    db   TID_WALL, $B6
    db   TID_STOP, $B8
    db   TID_WALL, $BD
    db   TID_WALL, $C6
    db   TID_WALL, $CD
    db   TID_WALL, $D6
    db   TID_WALL, $D7
    db   TID_WALL, $D8
    db   TID_WALL, $D9
    db   TID_WALL, $DA
    db   TID_WALL, $DB
    db   TID_WALL, $DC
    db   TID_WALL, $DD
    db   $FF

Level2:
    db   TID_FLAG, $16
    db   TID_FLAG, $17
    db   TID_FLAG, $18
    db   TID_FLAG, $19
    db   TID_FLAG, $1A
    db   TID_FLAG, $1B
    db   TID_FLAG, $1C
    db   TID_FLAG, $26
    db   TID_FLAG, $2C
    db   TID_FLAG, $33
    db   TID_FLAG, $34
    db   TID_FLAG, $35
    db   TID_FLAG, $36
    db   TID_IS, $38
    db   TID_WIN, $3A
    db   TID_FLAG, $3C
    db   TID_FLAG, $43
    db   TID_FLAG, $4C
    db   TID_FLAG, $53
    db   TID_LINK | TID_TEXT, $55
    db   TID_LINK, $59
    db   TID_FLAG, $5C
    db   TID_FLAG, $63
    db   TID_FLAG, $6C
    db   TID_FLAG, $73
    db   TID_FLAG, $74
    db   TID_FLAG, $75
    db   TID_FLAG, $76
    db   TID_FLAG, $77
    db   TID_FLAG, $78
    db   TID_FLAG, $79
    db   TID_FLAG, $7A
    db   TID_FLAG, $7B
    db   TID_FLAG, $7C
    db   TID_FLAG, $7D
    db   TID_FLAG, $86
    db   TID_FLAG, $8D
    db   TID_WALL | TID_TEXT, $94
    db   TID_FLAG, $96
    db   TID_FLAG | TID_TEXT, $98
    db   TID_WALL, $9A
    db   TID_FLAG, $9D
    db   TID_IS, $A4
    db   TID_FLAG, $A6
    db   TID_IS, $A8
    db   TID_FLAG, $AD
    db   TID_YOU, $B4
    db   TID_FLAG, $B6
    db   TID_STOP, $B8
    db   TID_FLAG, $BD
    db   TID_FLAG, $C6
    db   TID_FLAG, $CD
    db   TID_FLAG, $D6
    db   TID_FLAG, $D7
    db   TID_FLAG, $D8
    db   TID_FLAG, $D9
    db   TID_FLAG, $DA
    db   TID_FLAG, $DB
    db   TID_FLAG, $DC
    db   TID_FLAG, $DD
    db   $FF

Level3:
    db   TID_WALL | TID_TEXT, $00
    db   TID_LINK | TID_TEXT, $01
    db   TID_IS, $10
    db   TID_IS, $11
    db   TID_STOP, $20
    db   TID_YOU, $21
    db   TID_WALL, $24
    db   TID_WALL, $25
    db   TID_WALL, $26
    db   TID_WALL, $27
    db   TID_WALL, $28
    db   TID_WALL, $29
    db   TID_WALL, $2A
    db   TID_WALL, $2B
    db   TID_WALL, $34
    db   TID_WALL, $3B
    db   TID_WALL, $44
    db   TID_LINK, $46
    db   TID_ROCK, $48
    db   TID_WALL, $4B
    db   TID_WATR | TID_TEXT, $53
    db   TID_WALL, $54
    db   TID_WALL, $5B
    db   TID_IS, $63
    db   TID_WALL, $64
    db   TID_ROCK, $68
    db   TID_WALL, $6B
    db   TID_SINK, $73
    db   TID_WALL, $74
    db   TID_WALL, $7B
    db   TID_WALL, $81
    db   TID_WALL, $82
    db   TID_WALL, $83
    db   TID_WALL, $84
    db   TID_WATR, $85
    db   TID_WATR, $86
    db   TID_WATR, $87
    db   TID_WALL, $88
    db   TID_WALL, $89
    db   TID_WALL, $8A
    db   TID_WALL, $8B
    db   TID_WALL, $8C
    db   TID_WALL, $8D
    db   TID_WALL, $8E
    db   TID_WALL, $91
    db   TID_WALL, $98
    db   TID_WALL, $9E
    db   TID_WALL, $A1
    db   TID_WALL, $A8
    db   TID_ROCK | TID_TEXT, $AA
    db   TID_IS, $AB
    db   TID_PUSH, $AC
    db   TID_WALL, $AE
    db   TID_WALL, $B1
    db   TID_WATR, $B2
    db   TID_WATR, $B3
    db   TID_WATR, $B4
    db   TID_WALL, $BE
    db   TID_WALL, $C1
    db   TID_WATR, $C2
    db   TID_WATR, $C3
    db   TID_WATR, $C4
    db   TID_WALL, $C8
    db   TID_FLAG | TID_TEXT, $CA
    db   TID_IS, $CB
    db   TID_WIN, $CC
    db   TID_WALL, $CE
    db   TID_WALL, $D1
    db   TID_FLAG, $D2
    db   TID_WATR, $D3
    db   TID_WATR, $D4
    db   TID_WALL, $D8
    db   TID_WALL, $DE
    db   TID_WALL, $E1
    db   TID_WALL, $E2
    db   TID_WALL, $E3
    db   TID_WALL, $E4
    db   TID_WALL, $E5
    db   TID_WALL, $E6
    db   TID_WALL, $E7
    db   TID_WALL, $E8
    db   TID_WALL, $E9
    db   TID_WALL, $EA
    db   TID_WALL, $EB
    db   TID_WALL, $EC
    db   TID_WALL, $ED
    db   TID_WALL, $EE
    db   $FF

Level4:
    db   TID_LINK | TID_TEXT, $00
    db   TID_IS, $01
    db   TID_YOU, $02
    db   TID_FLAG | TID_TEXT, $10
    db   TID_IS, $11
    db   TID_WIN, $12
    db   TID_SKUL, $29
    db   TID_SKUL, $2A
    db   TID_SKUL, $2B
    db   TID_SKUL, $2C
    db   TID_SKUL, $2D
    db   TID_SKUL, $2E
    db   TID_SKUL, $39
    db   TID_SKUL, $3E
    db   TID_ROCK | TID_TEXT, $42
    db   TID_IS, $43
    db   TID_PUSH, $44
    db   TID_SKUL, $49
    db   TID_SKUL | TID_TEXT, $4B
    db   TID_SKUL, $4E
    db   TID_SKUL, $59
    db   TID_IS, $5B
    db   TID_SKUL, $5E
    db   TID_SKUL, $69
    db   TID_DEFEAT, $6B
    db   TID_SKUL, $6E
    db   TID_SKUL, $79
    db   TID_FLAG, $7C
    db   TID_SKUL, $7E
    db   TID_SKUL, $89
    db   TID_SKUL, $8E
    db   TID_SKUL, $99
    db   TID_SKUL, $9A
    db   TID_SKUL, $9B
    db   TID_SKUL, $9C
    db   TID_SKUL, $9D
    db   TID_SKUL, $9E
    db   TID_SKUL, $B1
    db   TID_ROCK, $B2
    db   TID_SKUL, $B3
    db   TID_SKUL, $C0
    db   TID_SKUL, $C1
    db   TID_ROCK, $C2
    db   TID_SKUL, $C3
    db   TID_SKUL, $C4
    db   TID_SKUL, $D0
    db   TID_ROCK, $D2
    db   TID_SKUL, $D4
    db   TID_SKUL, $E0
    db   TID_LINK, $E2
    db   TID_SKUL, $E4
    db   TID_SKUL, $F0
    db   TID_SKUL, $F4
    db   $FF

Level5:
    db   TID_FLAG | TID_TEXT, $00
    db   TID_IS, $01
    db   TID_WIN, $02
    db   TID_LAVA, $08
    db   TID_LAVA | TID_TEXT, $10
    db   TID_IS, $11
    db   TID_DEFEAT, $12
    db   TID_LAVA, $18
    db   TID_LAVA, $28
    db   TID_LINK, $36
    db   TID_LAVA, $38
    db   TID_FLAG, $3A
    db   TID_LAVA, $48
    db   TID_LINK | TID_TEXT, $53
    db   TID_BABA | TID_TEXT, $55
    db   TID_LAVA, $58
    db   TID_BABA, $5A
    db   TID_IS, $63
    db   TID_IS, $65
    db   TID_LAVA, $68
    db   TID_YOU, $73
    db   TID_LAVA, $78
    db   TID_LAVA, $88
    db   TID_LAVA, $98
    db   TID_LAVA, $A8
    db   TID_LAVA, $B8
    db   TID_LAVA, $C8
    db   TID_LAVA, $D8
    db   TID_LAVA, $E8
    db   TID_LAVA, $F8
    db   $FF

Level6:
    db   TID_WALL | TID_TEXT, $00
    db   TID_WALL, $01
    db   TID_WALL, $07
    db   TID_LAVA, $0B
    db   TID_LAVA, $0C
    db   TID_LAVA, $0D
    db   TID_LAVA, $0E
    db   TID_IS, $10
    db   TID_WALL, $11
    db   TID_BABA, $15
    db   TID_WALL, $17
    db   TID_LAVA, $1A
    db   TID_LAVA, $1B
    db   TID_LAVA, $1C
    db   TID_LAVA, $1D
    db   TID_LAVA, $1E
    db   TID_STOP, $20
    db   TID_WALL, $21
    db   TID_WALL, $27
    db   TID_LAVA, $2A
    db   TID_LAVA, $2B
    db   TID_LAVA, $2C
    db   TID_LAVA, $2D
    db   TID_WALL, $31
    db   TID_BABA | TID_TEXT, $33
    db   TID_IS, $34
    db   TID_YOU, $35
    db   TID_WALL, $37
    db   TID_LAVA, $3A
    db   TID_LAVA, $3B
    db   TID_LAVA, $3C
    db   TID_WALL, $41
    db   TID_WALL, $42
    db   TID_WALL, $46
    db   TID_WALL, $47
    db   TID_LAVA, $4A
    db   TID_LAVA, $4B
    db   TID_WALL, $51
    db   TID_ROCK, $57
    db   TID_LAVA, $5A
    db   TID_LAVA, $5B
    db   TID_WALL, $61
    db   TID_WALL, $62
    db   TID_WALL, $63
    db   TID_WALL, $64
    db   TID_WALL, $65
    db   TID_WALL, $66
    db   TID_WALL, $67
    db   TID_LAVA, $6A
    db   TID_LAVA, $6B
    db   TID_WALL, $71
    db   TID_ROCK | TID_TEXT, $72
    db   TID_WALL, $73
    db   TID_LAVA, $7A
    db   TID_LAVA, $7B
    db   $F0, TID_LINK, $7C
    db   TID_IS, $82
    db   TID_LAVA, $8A
    db   TID_LAVA, $8B
    db   TID_PUSH, $92
    db   TID_LAVA | TID_TEXT, $97
    db   TID_LAVA, $9A
    db   TID_LAVA, $9B
    db   TID_FLAG, $9E
    db   TID_LAVA, $AA
    db   TID_LAVA, $AB
    db   TID_LAVA, $BA
    db   TID_LAVA, $BB
    db   TID_FLAG | TID_TEXT, $BD
    db   TID_IS, $BE
    db   TID_WIN, $BF
    db   TID_WALL, $C4
    db   TID_BABA | TID_TEXT, $C5
    db   TID_IS, $C6
    db   TID_MELT, $C7
    db   TID_WALL, $C8
    db   TID_LAVA, $CA
    db   TID_LAVA, $CB
    db   TID_LAVA, $CC
    db   TID_WALL, $D4
    db   TID_LAVA | TID_TEXT, $D5
    db   TID_IS, $D6
    db   TID_HOT, $D7
    db   TID_WALL, $D8
    db   TID_LAVA, $D9
    db   TID_LAVA, $DA
    db   TID_LAVA, $DB
    db   TID_LAVA, $DC
    db   TID_WALL, $E4
    db   TID_WALL, $E5
    db   TID_WALL, $E6
    db   TID_WALL, $E7
    db   TID_WALL, $E8
    db   TID_LAVA, $E9
    db   TID_LAVA, $EA
    db   TID_LAVA, $EB
    db   TID_LAVA, $EC
    db   TID_LAVA, $F7
    db   TID_LAVA, $F8
    db   TID_LAVA, $F9
    db   TID_LAVA, $FA
    db   TID_LAVA, $FB
    db   TID_LAVA, $FC
    db   TID_LAVA, $FD
    db   $FF

Level7:
    db   TID_BABA | TID_TEXT, $00
    db   TID_IS, $01
    db   TID_YOU, $02
    db   TID_SKUL | TID_TEXT, $0D
    db   TID_IS, $0E
    db   TID_DEFEAT, $0F
    db   TID_KEKE, $47
    db   TID_KEKE | TID_TEXT, $52
    db   TID_IS, $53
    db   TID_MOVE, $54
    db   TID_SKUL, $59
    db   TID_SKUL, $5A
    db   TID_SKUL, $5B
    db   TID_SKUL, $5C
    db   TID_SKUL, $5D
    db   TID_SKUL, $69
    db   TID_SKUL, $6D
    db   TID_BABA, $75
    db   TID_SKUL, $79
    db   TID_LOVE, $7B
    db   TID_SKUL, $7D
    db   TID_SKUL, $89
    db   TID_SKUL, $8D
    db   TID_LOVE | TID_TEXT, $92
    db   TID_IS, $93
    db   TID_PUSH, $94
    db   TID_SKUL, $99
    db   TID_SKUL, $9A
    db   TID_SKUL, $9B
    db   TID_SKUL, $9C
    db   TID_SKUL, $9D
    db   $F0, TID_KEKE, $A6
    db   TID_LOVE | TID_TEXT, $D0
    db   TID_IS, $E0
    db   TID_WIN, $F0
    db   $FF

Level8:
    db   TID_WALL, $08
    db   TID_WALL | TID_TEXT, $0F
    db   TID_WALL, $18
    db   TID_IS, $1F
    db   TID_BABA | TID_TEXT, $23
    db   TID_IS, $24
    db   TID_YOU, $25
    db   TID_WALL, $28
    db   TID_STOP, $2F
    db   TID_BABA, $36
    db   TID_WALL, $38
    db   TID_FLAG, $3A
    db   TID_FLAG | TID_TEXT, $43
    db   TID_IS, $44
    db   TID_WIN, $45
    db   TID_WALL, $48
    db   TID_WALL, $58
    db   TID_WALL, $68
    db   TID_WALL, $78
    db   TID_WALL, $80
    db   TID_WALL, $81
    db   TID_WALL, $82
    db   TID_WALL, $83
    db   TID_WALL, $84
    db   TID_WALL, $85
    db   TID_WALL, $86
    db   TID_WALL, $87
    db   TID_WALL, $88
    db   $FF

Level8Bonus:
    db   TID_FLAG | TID_TEXT, $00
    db   TID_IS, $01
    db   TID_WIN, $02
    db   TID_WALL, $21
    db   TID_WALL, $22
    db   TID_WALL, $23
    db   TID_WALL, $24
    db   TID_WALL, $25
    db   TID_WALL, $26
    db   TID_WALL, $27
    db   TID_WALL, $28
    db   TID_WALL, $29
    db   TID_WALL, $31
    db   TID_WALL, $39
    db   TID_WALL, $41
    db   TID_WALL, $49
    db   TID_WALL, $51
    db   TID_BABA | TID_TEXT, $54
    db   TID_IS, $55
    db   TID_YOU, $56
    db   TID_WALL, $59
    db   TID_FLAG, $5B
    db   TID_WALL, $61
    db   TID_WALL, $69
    db   TID_WALL, $71
    db   TID_BABA, $74
    db   TID_WALL, $79
    db   TID_WALL, $7A
    db   TID_WALL, $7B
    db   TID_WALL, $81
    db   TID_WALL, $8B
    db   TID_WALL, $91
    db   TID_KEKE | TID_TEXT, $94
    db   TID_PUSH, $96
    db   TID_KEKE, $98
    db   TID_WALL | TID_TEXT, $9A
    db   TID_WALL, $9B
    db   TID_WALL, $A1
    db   TID_IS, $AA
    db   TID_WALL, $AB
    db   TID_WALL, $B1
    db   TID_STOP, $BA
    db   TID_WALL, $BB
    db   TID_WALL, $C1
    db   TID_WALL, $CB
    db   TID_WALL, $D1
    db   TID_WALL, $D2
    db   TID_WALL, $D3
    db   TID_WALL, $D4
    db   TID_WALL, $D5
    db   TID_WALL, $D6
    db   TID_WALL, $D7
    db   TID_WALL, $D8
    db   TID_WALL, $D9
    db   TID_WALL, $DA
    db   TID_WALL, $DB
    db   $FF

Level9:
    db   TID_WALL, $06
    db   TID_WALL, $07
    db   TID_WALL, $08
    db   TID_WALL, $09
    db   TID_WALL, $0A
    db   TID_ROCK | TID_TEXT, $17
    db   TID_IS, $18
    db   TID_ROCK | TID_TEXT, $19
    db   TID_BABA, $36
    db   TID_FLAG, $38
    db   TID_FLAG | TID_TEXT, $57
    db   TID_IS, $58
    db   TID_ROCK | TID_TEXT, $59
    db   TID_WALL, $C0
    db   TID_WALL, $C1
    db   TID_WALL, $C2
    db   TID_WALL, $C3
    db   TID_BABA | TID_TEXT, $D0
    db   TID_FLAG | TID_TEXT, $D1
    db   TID_WALL | TID_TEXT, $D2
    db   TID_WALL, $D3
    db   TID_IS, $E0
    db   TID_IS, $E1
    db   TID_IS, $E2
    db   TID_WALL, $E3
    db   TID_YOU, $F0
    db   TID_WIN, $F1
    db   TID_STOP, $F2
    db   TID_WALL, $F3
    db   $FF

Level9Bonus:
    db   TID_WALL, $09
    db   TID_WALL, $19
    db   TID_WALL, $1A
    db   TID_WALL, $1B
    db   TID_WALL, $1C
    db   TID_WALL, $1D
    db   TID_WALL, $1E
    db   TID_WALL, $1F
    db   TID_BABA, $24
    db   TID_ROCK, $29
    db   TID_SKUL | TID_TEXT, $2C
    db   TID_FLAG | TID_TEXT, $2D
    db   TID_WALL, $2F
    db   TID_BABA | TID_TEXT, $33
    db   TID_IS, $34
    db   TID_YOU, $35
    db   TID_WALL, $39
    db   TID_WALL, $3C
    db   TID_IS, $3D
    db   TID_IS, $3E
    db   TID_WALL, $3F
    db   TID_WALL, $49
    db   TID_WALL, $4C
    db   TID_DEFEAT, $4D
    db   TID_WIN, $4E
    db   TID_WALL, $4F
    db   TID_WALL, $55
    db   TID_WALL, $56
    db   TID_WALL, $57
    db   TID_WALL, $58
    db   TID_WALL, $59
    db   TID_WALL, $5C
    db   TID_WALL, $5D
    db   TID_WALL, $5E
    db   TID_WALL, $5F
    db   TID_WALL, $65
    db   TID_WALL, $69
    db   TID_WALL, $6F
    db   TID_SKUL, $75
    db   TID_SKUL, $76
    db   TID_FLAG, $77
    db   TID_WALL, $79
    db   TID_ROCK | TID_TEXT, $7B
    db   TID_IS, $7C
    db   TID_PUSH, $7D
    db   TID_WALL, $7F
    db   TID_WALL | TID_TEXT, $81
    db   TID_IS, $82
    db   TID_STOP, $83
    db   TID_WALL, $84
    db   TID_WALL, $85
    db   TID_WALL, $89
    db   TID_WALL, $8F
    db   TID_WALL, $90
    db   TID_WALL, $91
    db   TID_WALL, $92
    db   TID_WALL, $93
    db   TID_WALL, $94
    db   TID_WALL, $95
    db   TID_WALL, $96
    db   TID_WALL, $97
    db   TID_WALL, $98
    db   TID_WALL, $99
    db   TID_WALL, $9A
    db   TID_WALL, $9B
    db   TID_WALL, $9C
    db   TID_WALL, $9D
    db   TID_WALL, $9E
    db   TID_WALL, $9F
    db   $FF

Level10:
    db   TID_WALL | TID_TEXT, $00
    db   TID_IS, $01
    db   TID_STOP, $02
    db   TID_WALL, $03
    db   TID_WALL, $10
    db   TID_WALL, $11
    db   TID_WALL, $12
    db   TID_WALL, $13
    db   TID_FLAG | TID_TEXT, $40
    db   TID_IS, $41
    db   TID_FLAG | TID_TEXT, $42
    db   TID_WALL, $50
    db   TID_WALL, $51
    db   TID_WALL, $52
    db   TID_WALL, $53
    db   TID_WALL, $54
    db   TID_WALL, $55
    db   TID_WALL, $56
    db   TID_WALL, $57
    db   TID_WALL, $58
    db   TID_WALL, $59
    db   TID_WALL, $69
    db   TID_FLAG | TID_TEXT, $74
    db   TID_IS, $75
    db   TID_PUSH, $76
    db   TID_WALL, $79
    db   TID_WALL, $7A
    db   TID_WALL, $7B
    db   TID_WALL, $7C
    db   TID_WALL, $7D
    db   TID_WALL, $7E
    db   TID_WALL, $7F
    db   TID_WALL, $89
    db   TID_BABA, $92
    db   TID_LOVE | TID_TEXT, $96
    db   TID_FLAG, $99
    db   TID_WALL, $9B
    db   TID_WALL, $A4
    db   TID_WALL, $A9
    db   TID_WALL, $B0
    db   TID_WALL, $B1
    db   TID_BABA | TID_TEXT, $B2
    db   TID_IS, $B3
    db   TID_YOU, $B4
    db   TID_WALL, $B9
    db   TID_WALL, $C0
    db   TID_WALL, $C1
    db   TID_WALL, $C2
    db   TID_WALL, $C3
    db   TID_WALL, $C4
    db   TID_WALL, $C5
    db   TID_WALL, $C6
    db   TID_WALL, $C7
    db   TID_WALL, $C8
    db   TID_WALL, $C9
    db   TID_FLAG | TID_TEXT, $CB
    db   TID_IS, $CC
    db   TID_STOP, $CD
    db   TID_LOVE | TID_TEXT, $D1
    db   TID_IS, $E1
    db   TID_LOVE, $E3
    db   TID_WIN, $F1
    db   $FF

Level11:
    db   TID_KEKE | TID_TEXT, $03
    db   TID_IS, $04
    db   TID_STOP, $05
    db   TID_KEKE | TID_TEXT, $13
    db   TID_IS, $14
    db   TID_YOU, $15
    db   TID_WALL, $20
    db   TID_WALL, $21
    db   TID_WALL, $22
    db   TID_WALL, $23
    db   TID_WALL, $24
    db   TID_WALL, $25
    db   TID_WALL, $26
    db   TID_WALL, $27
    db   TID_WALL, $28
    db   TID_WALL, $29
    db   TID_WALL, $2A
    db   TID_FLAG | TID_TEXT, $2C
    db   TID_IS, $2D
    db   TID_WIN, $2E
    db   TID_WALL, $30
    db   TID_WATR, $36
    db   TID_WALL, $3A
    db   TID_WALL, $3B
    db   TID_WALL, $3C
    db   TID_WALL, $3D
    db   TID_WALL, $3E
    db   TID_WALL, $3F
    db   TID_WALL, $40
    db   TID_WATR, $46
    db   TID_WALL, $4A
    db   TID_WALL, $50
    db   TID_KEKE, $53
    db   TID_WATR, $56
    db   TID_WALL, $5A
    db   TID_WALL, $60
    db   TID_WATR, $66
    db   TID_WALL, $6A
    db   TID_FLAG, $6D
    db   TID_WALL, $70
    db   TID_BABA | TID_TEXT, $74
    db   TID_WATR, $76
    db   TID_WALL, $7A
    db   TID_WALL, $80
    db   TID_WATR, $86
    db   TID_IS, $88
    db   TID_WALL, $8A
    db   TID_WALL, $90
    db   TID_WATR, $96
    db   TID_YOU, $98
    db   TID_WALL, $9A
    db   TID_BABA, $9D
    db   TID_WALL, $A0
    db   TID_KEKE, $A3
    db   TID_WATR, $A6
    db   TID_WALL, $AA
    db   TID_WALL, $B0
    db   TID_WATR, $B6
    db   TID_WALL, $BA
    db   TID_WALL, $C0
    db   TID_WATR, $C6
    db   TID_WALL, $CA
    db   TID_WALL, $CB
    db   TID_WALL, $CC
    db   TID_WALL, $CD
    db   TID_WALL, $CE
    db   TID_WALL, $CF
    db   TID_WALL, $D0
    db   TID_WALL, $D1
    db   TID_WALL, $D2
    db   TID_WALL, $D3
    db   TID_WALL, $D4
    db   TID_WALL, $D5
    db   TID_WALL, $D6
    db   TID_WALL, $D7
    db   TID_WALL, $D8
    db   TID_WALL, $D9
    db   TID_WALL, $DA
    db   TID_WALL | TID_TEXT, $E3
    db   TID_IS, $E4
    db   TID_STOP, $E5
    db   TID_WATR | TID_TEXT, $F3
    db   TID_IS, $F4
    db   TID_SINK, $F5
    db   $FF

Level12:
    db   TID_WALL, $0C
    db   TID_SKUL | TID_TEXT, $0D
    db   TID_IS, $0E
    db   TID_DEFEAT, $0F
    db   TID_WALL, $1C
    db   TID_WALL | TID_TEXT, $1D
    db   TID_IS, $1E
    db   TID_STOP, $1F
    db   TID_WALL, $28
    db   TID_WALL, $2C
    db   TID_WALL, $2D
    db   TID_WALL, $2E
    db   TID_WALL, $2F
    db   TID_WALL, $43
    db   TID_WALL, $60
    db   TID_WALL, $61
    db   TID_WALL, $62
    db   TID_SKUL, $64
    db   TID_SKUL, $65
    db   TID_SKUL, $66
    db   TID_SKUL, $67
    db   TID_WALL, $70
    db   TID_WALL, $71
    db   TID_WALL, $72
    db   TID_WIN, $73
    db   TID_SKUL, $74
    db   TID_SKUL, $75
    db   TID_SKUL, $76
    db   TID_SKUL, $77
    db   TID_SKUL, $86
    db   TID_SKUL, $87
    db   TID_BABA, $89
    db   TID_WALL, $93
    db   TID_SKUL, $96
    db   TID_SKUL, $97
    db   TID_BABA | TID_TEXT, $9B
    db   TID_KEKE | TID_TEXT, $9D
    db   TID_SKUL, $A6
    db   TID_SKUL, $A7
    db   TID_IS, $AB
    db   TID_IS, $AD
    db   TID_KEKE, $B3
    db   TID_SKUL, $B6
    db   TID_SKUL, $B7
    db   TID_YOU, $BB
    db   TID_MOVE, $BD
    db   TID_SKUL, $C6
    db   TID_SKUL, $C7
    db   TID_SKUL, $D6
    db   TID_SKUL, $D7
    db   TID_WALL, $E3
    db   TID_SKUL, $E6
    db   TID_SKUL, $E7
    db   TID_SKUL, $F6
    db   TID_SKUL, $F7
    db   $FF

Level13:
    db   TID_WALL | TID_TEXT, $00
    db   TID_IS, $01
    db   TID_STOP, $02
    db   TID_WALL, $03
    db   TID_LAVA, $0A
    db   TID_BABA | TID_TEXT, $10
    db   TID_IS, $11
    db   TID_YOU, $12
    db   TID_WALL, $13
    db   TID_KEKE | TID_TEXT, $16
    db   TID_IS, $17
    db   TID_STOP, $18
    db   TID_LAVA, $1A
    db   TID_FLAG | TID_TEXT, $1D
    db   TID_WALL, $1E
    db   TID_WALL, $1F
    db   TID_FLAG | TID_TEXT, $20
    db   TID_IS, $21
    db   TID_FLAG | TID_TEXT, $22
    db   TID_WALL, $23
    db   TID_KEKE, $26
    db   TID_LAVA, $2A
    db   TID_LAVA | TID_TEXT, $30
    db   TID_IS, $31
    db   TID_DEFEAT, $32
    db   TID_WALL, $33
    db   TID_IS, $37
    db   TID_MOVE, $38
    db   TID_LAVA, $3A
    db   TID_WIN, $3D
    db   TID_WALL, $3E
    db   TID_WALL, $3F
    db   TID_WATR | TID_TEXT, $40
    db   TID_IS, $41
    db   TID_DEFEAT, $42
    db   TID_WALL, $43
    db   TID_ROCK, $46
    db   TID_LAVA, $4A
    db   TID_WATR | TID_TEXT, $4D
    db   TID_WALL, $4E
    db   TID_WALL, $4F
    db   TID_WATR | TID_TEXT, $50
    db   TID_IS, $51
    db   TID_MELT, $52
    db   TID_WALL, $53
    db   TID_ROCK | TID_TEXT, $56
    db   TID_IS, $57
    db   TID_PUSH, $58
    db   TID_LAVA, $5A
    db   TID_WALL, $60
    db   TID_WALL, $61
    db   TID_WALL, $62
    db   TID_WALL, $63
    db   TID_LAVA, $6A
    db   TID_HOT, $6D
    db   TID_WALL, $6E
    db   TID_WALL, $6F
    db   TID_LAVA, $7A
    db   TID_BABA, $86
    db   TID_LAVA, $8A
    db   TID_LAVA, $9A
    db   TID_LAVA, $AA
    db   TID_WATR, $B2
    db   TID_WATR, $B3
    db   TID_WATR, $B4
    db   TID_LAVA, $BA
    db   TID_WATR, $C2
    db   TID_FLAG, $C3
    db   TID_WATR, $C4
    db   TID_LAVA, $CA
    db   TID_WATR, $D2
    db   TID_WATR, $D3
    db   TID_WATR, $D4
    db   TID_LAVA, $DA
    db   TID_LAVA, $EA
    db   TID_LAVA, $FA
    db   $FF

Level14:
    db   TID_LINK | TID_TEXT, $14
    db   TID_IS, $15
    db   TID_YOU, $16
    db   TID_LINK, $44
    db   $FF

}