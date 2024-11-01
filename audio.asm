#SECTION "AudioWRAM", WRAM0 {
wAudioDelay: ds 1
wAudioPtr: ds 2
}

#SECTION "AudioCode", ROM0 {

audioInit:
    ld   a, $80
    ldh  [rNR52], a
    ld   a, $ff
    ldh  [rNR51], a
    ld   a, $77
    ldh  [rNR50], a

    xor  a
    ldh  [rNR10], a
    ld   a, $80
    ldh  [rNR11], a
    ld   a, $F0
    ldh  [rNR12], a
    ld   a, $40
    ldh  [rNR14], a
    ld   a, $80
    ldh  [rNR21], a
    ld   a, $F0
    ldh  [rNR22], a
    ld   a, $40
    ldh  [rNR24], a

    xor  a
    ldh  [rNR30], a
    ld   a, $01
    ldh  [rNR31], a
    ld   a, $20
    ldh  [rNR32], a
    ld   a, $40
    ldh  [rNR34], a

    ld   hl, waveData
    ld   de, $FF30
    ld   bc, 16
    call copyData

    ld   a, $80
    ldh  [rNR30], a

    ld   hl, wAudioPtr
    ld   a, LOW(audioData)
    ld   [hl+], a
    ld   a, HIGH(audioData)
    ld   [hl+], a
    ld   a, 5
    ld   [wAudioDelay], a
    ret

audioUpdate:
    ldh  a, [hLagFrames]
    ld   c, a
    inc  c
    ld   hl, wAudioDelay
    ld   a, [hl]
    sub  c
    ld   [hl], a
    ret  nc
    ld   a, 14
    ld   [hl], a

    ld   hl, wAudioPtr
    ld   a, [hl+]
    ld   h, [hl]
    ld   l, a

    ld   a, [hl+]
    and  a
    jr   z, .skipChannel1
    sub  a, 12
    jr   c, .restart
    add  a, a
    add  a, LOW(freqTable)
    ld   e, a
    adc  a, HIGH(freqTable)
    sub  e
    ld   d, a
    ld   a, $80
    ldh  [rNR11], a
    ld   a, [de]
    inc  de
    ldh  [rNR13], a
    ld   a, [de]
    ldh  [rNR14], a
.skipChannel1:

    ld   a, [hl+]
    and  a
    jr   z, .skipChannel2
    sub  a, 12
    add  a, a
    add  a, LOW(freqTable)
    ld   e, a
    adc  a, HIGH(freqTable)
    sub  e
    ld   d, a
    ld   a, $80
    ldh  [rNR21], a
    ld   a, [de]
    inc  de
    ldh  [rNR23], a
    ld   a, [de]
    ldh  [rNR24], a
.skipChannel2:

    ld   a, [hl+]
    and  a
    jr   z, .skipChannel3
    sub  a, 12
    add  a, a
    add  a, LOW(freqTable)
    ld   e, a
    adc  a, HIGH(freqTable)
    sub  e
    ld   d, a
    ld   a, $C0
    ldh  [rNR31], a
    ld   a, [de]
    inc  de
    ldh  [rNR33], a
    ld   a, [de]
    ldh  [rNR34], a
.skipChannel3:
    inc  hl ; skip channel4

.saveAudioPtr:
    ld   a, l
    ld   [wAudioPtr], a
    ld   a, h
    ld   [wAudioPtr+1], a
    ret
.restart:
    ld   hl, audioData
    jr   .saveAudioPtr

#MACRO NFREQ _freq {
    ; Frequencies that are too low to manage... so we put in longest period
    dw $C001
}

#MACRO FREQ _freq {
    ; _freq = frequency in centi-herz
    ; Hz = 131072 / (2048-period_value)
    ; 2048-(131072 / Hz) = period_value
    VAL = (2048 - (13107200 / _freq))
    ;#IF VAL < 1
    ;    VAL = 1
    ;#ENDIF
    dw VAL | $C000
}

waveData:
    db $33, $33, $33, $33, $00, $00, $00, $00
    db $33, $33, $33, $33, $00, $00, $00, $00

freqTable:
    NFREQ 1635 ; C0
    NFREQ 1732
    NFREQ 1835
    NFREQ 1945
    NFREQ 2060
    NFREQ 2183
    NFREQ 2312
    NFREQ 2450
    NFREQ 2596
    NFREQ 2750
    NFREQ 2914
    NFREQ 3087
    NFREQ 3270
    NFREQ 3465
    NFREQ 3671
    NFREQ 3889
    NFREQ 4120
    NFREQ 4365
    NFREQ 4625
    NFREQ 4900
    NFREQ 5191
    NFREQ 5500
    NFREQ 5827
    NFREQ 6174
    FREQ 6541
    FREQ 6930
    FREQ 7342
    FREQ 7778
    FREQ 8241
    FREQ 8731
    FREQ 9250
    FREQ 9800
    FREQ 10383
    FREQ 11000
    FREQ 11654
    FREQ 12347
    FREQ 13081
    FREQ 13859
    FREQ 14683
    FREQ 15556
    FREQ 16481
    FREQ 17461
    FREQ 18500
    FREQ 19600
    FREQ 20765
    FREQ 22000
    FREQ 23308
    FREQ 24694
    FREQ 26163
    FREQ 27718
    FREQ 29366
    FREQ 31113
    FREQ 32963
    FREQ 34923
    FREQ 36999
    FREQ 39200
    FREQ 41530
    FREQ 44000
    FREQ 46616
    FREQ 49388
    FREQ 52325
    FREQ 55437
    FREQ 58733
    FREQ 62225
    FREQ 65925
    FREQ 69846
    FREQ 73999
    FREQ 78399
    FREQ 83061
    FREQ 88000
    FREQ 93233
    FREQ 98777
    FREQ 104650
    FREQ 110873
    FREQ 117466
    FREQ 124451
    FREQ 131851
    FREQ 139691
    FREQ 147998
    FREQ 156798
    FREQ 166122
    FREQ 176000
    FREQ 186466
    FREQ 197553
    FREQ 209300
    FREQ 221746
    FREQ 234932
    FREQ 248902
    FREQ 263702
    FREQ 279383
    FREQ 295996
    FREQ 313596
    FREQ 332244
    FREQ 352000
    FREQ 372931
    FREQ 395107
    FREQ 418601
    FREQ 443492
    FREQ 469863
    FREQ 497803
    FREQ 527404
    FREQ 558765
    FREQ 591991
    FREQ 627193
    FREQ 664488
    FREQ 704000
    FREQ 745862
    FREQ 790213 ; D#8

}

#INCLUDE "music_data.asm"