#SECTION "ObjectMetaTiles", ROM0 {
; Tile data, 3 bytes per TID
; Byte0: Render type
;   0 = 4x same tile
;   1 = 4x incremental tile
;   2 = 4x incremental tile + direction
; Byte1: Tile index start
; Byte2: Tile attrib data
MetaTileData:
    db $02, $02, $00 ; 00 TID_BABA
    db $01, $08, $06 ; 01 TID_FLAG
    db $01, $0A, $00 ; 02 TID_WALL
    db $01, $0C, $06 ; 03 TID_ROCK
    db $00, $10, $03 ; 04 TID_WATR
    db $01, $0E, $01 ; 05 TID_SKUL
    db $00, $10, $01 ; 06 TID_LAVA
    db $02, $40, $01 ; 07 TID_KEKE
    db $01, $46, $04 ; 08 TID_LOVE
    db $00, $01, $00 ; 09
    db $00, $01, $00 ; 0A
    db $00, $01, $00 ; 0B
    db $00, $01, $00 ; 0C
    db $00, $01, $00 ; 0D
    db $00, $01, $00 ; 0E
    db $00, $01, $00 ; 0F
    db $00, $01, $00 ; 10
    db $00, $01, $00 ; 11
    db $00, $01, $00 ; 12
    db $00, $01, $00 ; 13
    db $00, $01, $00 ; 14
    db $00, $01, $00 ; 15
    db $00, $01, $00 ; 16
    db $00, $01, $00 ; 17
    db $00, $01, $00 ; 18
    db $00, $01, $00 ; 19
    db $00, $01, $00 ; 1A
    db $00, $01, $00 ; 1B
    db $00, $01, $00 ; 1C
    db $00, $01, $00 ; 1D
    db $00, $01, $00 ; 1E
    db $00, $01, $00 ; 1F
    db $00, $01, $00 ; 20
    db $00, $01, $00 ; 21
    db $00, $01, $00 ; 22
    db $00, $01, $00 ; 23
    db $00, $01, $00 ; 24
    db $00, $01, $00 ; 25
    db $00, $01, $00 ; 26
    db $00, $01, $00 ; 27
    db $00, $01, $00 ; 28
    db $00, $01, $00 ; 29
    db $00, $01, $00 ; 2A
    db $00, $01, $00 ; 2B
    db $00, $01, $00 ; 2C
    db $00, $01, $00 ; 2D
    db $00, $01, $00 ; 2E
    db $00, $01, $00 ; 2F
    db $00, $01, $00 ; 30
    db $00, $01, $00 ; 31
    db $00, $01, $00 ; 32
    db $00, $01, $00 ; 33
    db $00, $01, $00 ; 34
    db $00, $01, $00 ; 35
    db $00, $01, $00 ; 36
    db $00, $01, $00 ; 37
    db $00, $01, $00 ; 38
    db $00, $01, $00 ; 39
    db $00, $01, $00 ; 3A
    db $00, $01, $00 ; 3B
    db $00, $01, $00 ; 3C
    db $00, $01, $00 ; 3D
    db $00, $01, $00 ; 3E TID_ISLAND
    db $02, $80, $07 ; 3F TID_LINK
    db $01, $20, $00 ; 40 TID_IS
    db $00, $01, $00 ; 41
    db $00, $01, $00 ; 42
    db $00, $01, $00 ; 43
    db $00, $01, $00 ; 44
    db $00, $01, $00 ; 45
    db $00, $01, $00 ; 46
    db $00, $01, $00 ; 47
    db $00, $01, $00 ; 48
    db $00, $01, $00 ; 49
    db $00, $01, $00 ; 4A
    db $00, $01, $00 ; 4B
    db $00, $01, $00 ; 4C
    db $00, $01, $00 ; 4D
    db $00, $01, $00 ; 4E
    db $00, $01, $00 ; 4F
    db $00, $01, $00 ; 50
    db $00, $01, $00 ; 51
    db $00, $01, $00 ; 52
    db $00, $01, $00 ; 53
    db $00, $01, $00 ; 54
    db $00, $01, $00 ; 55
    db $00, $01, $00 ; 56
    db $00, $01, $00 ; 57
    db $00, $01, $00 ; 58
    db $00, $01, $00 ; 59
    db $00, $01, $00 ; 5A
    db $00, $01, $00 ; 5B
    db $00, $01, $00 ; 5C
    db $00, $01, $00 ; 5D
    db $00, $01, $00 ; 5E
    db $00, $01, $00 ; 5F
    db $00, $01, $00 ; 60
    db $00, $01, $00 ; 61
    db $00, $01, $00 ; 62
    db $00, $01, $00 ; 63
    db $00, $01, $00 ; 64
    db $00, $01, $00 ; 65
    db $00, $01, $00 ; 66
    db $00, $01, $00 ; 67
    db $00, $01, $00 ; 68
    db $00, $01, $00 ; 69
    db $00, $01, $00 ; 6A
    db $00, $01, $00 ; 6B
    db $00, $01, $00 ; 6C
    db $00, $01, $00 ; 6D
    db $00, $01, $00 ; 6E
    db $00, $01, $00 ; 6F
    db $00, $01, $00 ; 70
    db $00, $01, $00 ; 71
    db $00, $01, $00 ; 72
    db $00, $01, $00 ; 73
    db $00, $01, $00 ; 74
    db $00, $01, $00 ; 75
    db $00, $01, $00 ; 76
    db $00, $01, $00 ; 77
    db $00, $01, $00 ; 78
    db $00, $01, $00 ; 79
    db $00, $01, $00 ; 7A
    db $00, $01, $00 ; 7B
    db $00, $01, $00 ; 7C
    db $00, $01, $00 ; 7D
    db $00, $01, $00 ; 7E
    db $00, $01, $00 ; 7F
    db $01, $22, $04 ; 80 TID_BABA | TID_TEXT
    db $01, $24, $06 ; 81 TID_FLAG | TID_TEXT
    db $01, $26, $00 ; 82 TID_WALL | TID_TEXT
    db $01, $28, $06 ; 83 TID_ROCK | TID_TEXT
    db $01, $2A, $03 ; 84 TID_WATR | TID_TEXT
    db $01, $2C, $01 ; 85 TID_SKUL | TID_TEXT
    db $01, $2E, $01 ; 86 TID_LAVA | TID_TEXT
    db $01, $60, $01 ; 87 TID_KEKE | TID_TEXT
    db $01, $62, $04 ; 88 TID_LOVE | TID_TEXT
    db $00, $01, $00 ; 89
    db $00, $01, $00 ; 8A
    db $00, $01, $00 ; 8B
    db $00, $01, $00 ; 8C
    db $00, $01, $00 ; 8D
    db $00, $01, $00 ; 8E
    db $00, $01, $00 ; 8F
    db $00, $01, $00 ; 90
    db $00, $01, $00 ; 91
    db $00, $01, $00 ; 92
    db $00, $01, $00 ; 93
    db $00, $01, $00 ; 94
    db $00, $01, $00 ; 95
    db $00, $01, $00 ; 96
    db $00, $01, $00 ; 97
    db $00, $01, $00 ; 98
    db $00, $01, $00 ; 99
    db $00, $01, $00 ; 9A
    db $00, $01, $00 ; 9B
    db $00, $01, $00 ; 9C
    db $00, $01, $00 ; 9D
    db $00, $01, $00 ; 9E
    db $00, $01, $00 ; 9F
    db $00, $01, $00 ; A0
    db $00, $01, $00 ; A1
    db $00, $01, $00 ; A2
    db $00, $01, $00 ; A3
    db $00, $01, $00 ; A4
    db $00, $01, $00 ; A5
    db $00, $01, $00 ; A6
    db $00, $01, $00 ; A7
    db $00, $01, $00 ; A8
    db $00, $01, $00 ; A9
    db $00, $01, $00 ; AA
    db $00, $01, $00 ; AB
    db $00, $01, $00 ; AC
    db $00, $01, $00 ; AD
    db $00, $01, $00 ; AE
    db $00, $01, $00 ; AF
    db $00, $01, $00 ; B0
    db $00, $01, $00 ; B1
    db $00, $01, $00 ; B2
    db $00, $01, $00 ; B3
    db $00, $01, $00 ; B4
    db $00, $01, $00 ; B5
    db $00, $01, $00 ; B6
    db $00, $01, $00 ; B7
    db $00, $01, $00 ; B8
    db $00, $01, $00 ; B9
    db $00, $01, $00 ; BA
    db $00, $01, $00 ; BB
    db $00, $01, $00 ; BC
    db $00, $01, $00 ; BD
    db $01, $A2, $00 ; BE TID_ISLAND | TID_TEXT
    db $01, $A0, $07 ; BF TID_LINK | TID_TEXT
    db $01, $E0, $04 ; C0 TID_YOU
    db $01, $E2, $06 ; C1 TID_WIN
    db $01, $E4, $02 ; C2 TID_STOP
    db $01, $E6, $06 ; C3 TID_PUSH
    db $01, $E8, $03 ; C4 TID_SINK
    db $01, $EA, $01 ; C5 TID_DEFEAT
    db $01, $EC, $01 ; C6 TID_HOT
    db $01, $EE, $03 ; C7 TID_MELT
    db $01, $C0, $02 ; C8 TID_MOVE
    db $01, $A4, $07 ; C9 TID_REAL
    db $00, $01, $00 ; CA
    db $00, $01, $00 ; CB
    db $00, $01, $00 ; CC
    db $00, $01, $00 ; CD
    db $00, $01, $00 ; CE
    db $00, $01, $00 ; CF
    db $00, $01, $00 ; D0
    db $00, $01, $00 ; D1
    db $00, $01, $00 ; D2
    db $00, $01, $00 ; D3
    db $00, $01, $00 ; D4
    db $00, $01, $00 ; D5
    db $00, $01, $00 ; D6
    db $00, $01, $00 ; D7
    db $00, $01, $00 ; D8
    db $00, $01, $00 ; D9
    db $00, $01, $00 ; DA
    db $00, $01, $00 ; DB
    db $00, $01, $00 ; DC
    db $00, $01, $00 ; DD
    db $00, $01, $00 ; DE
    db $00, $01, $00 ; DF
    db $00, $01, $00 ; E0
    db $00, $01, $00 ; E1
    db $00, $01, $00 ; E2
    db $00, $01, $00 ; E3
    db $00, $01, $00 ; E4
    db $00, $01, $00 ; E5
    db $00, $01, $00 ; E6
    db $00, $01, $00 ; E7
    db $00, $01, $00 ; E8
    db $00, $01, $00 ; E9
    db $00, $01, $00 ; EA
    db $00, $01, $00 ; EB
    db $00, $01, $00 ; EC
    db $00, $01, $00 ; ED
    db $00, $01, $00 ; EE
    db $00, $01, $00 ; EF
    db $00, $01, $00 ; F0
    db $00, $01, $00 ; F1
    db $00, $01, $00 ; F2
    db $00, $01, $00 ; F3
    db $00, $01, $00 ; F4
    db $00, $01, $00 ; F5
    db $00, $01, $00 ; F6
    db $00, $01, $00 ; F7
    db $00, $01, $00 ; F8
    db $00, $01, $00 ; F9
    db $00, $01, $00 ; FA
    db $00, $01, $00 ; FB
    db $00, $01, $00 ; FC
    db $00, $01, $00 ; FD
    db $00, $01, $00 ; FE
    db $00, $00, $00 ; FF TID_NO_OBJECT
}