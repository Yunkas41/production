		LIST P=PIC16F84A
		#INCLUDE<P16F84A.INC>
		
		__CONFIG _HS_OSC&_CP_OFF&_WDT_OFF&_PWRTE_ON

W_TEMP		EQU		0CH
STATUS_TEMP	EQU		0DH
CNT1		EQU		0EH
CNTB		EQU		0FH
TMPA		EQU		010H
OUT			EQU		011H
OUT_HIGH	EQU		012H
IN			EQU		013H
		ORG		0H
		GOTO	MAIN
		ORG		04H
;PUSH
	MOVWF	W_TEMP
	MOVF	STATUS,W
	MOVWF	STATUS_TEMP
	CALL	CRECV
	MOVWF	OUT
	ANDLW	B'11110000'
	MOVWF	OUT_HIGH
	MOVLW	B'01100000'
	XORWF	OUT_HIGH,W
	BTFSC	STATUS,Z
	GOTO	ASCII_HIGH_6
	MOVLW	B'01110000'
	XORWF	OUT_HIGH,W
	BTFSC	STATUS,Z
	GOTO	ASCII_HIGH_7
CHRA_END
	MOVF	OUT,W
	CALL	CSEND
;POP
	MOVF	STATUS_TEMP,W
	MOVWF	STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W
	BCF		INTCON,INTF
	RETFIE
ASCII_HIGH_6
	MOVLW	'`'
	XORWF	OUT,W
	BTFSC	STATUS,Z
	GOTO	CHRA_END
	MOVLW	B'00100000'
	SUBWF	OUT,F
	GOTO	CHRA_END
ASCII_HIGH_7
	MOVLW	'{'
	XORWF	OUT,W
	BTFSC	STATUS,Z
	GOTO	CHRA_END
	MOVLW	'|'
	XORWF	OUT,W
	BTFSC	STATUS,Z
	GOTO	CHRA_END
	MOVLW	'}'
	XORWF	OUT,W
	BTFSC	STATUS,Z
	GOTO	CHRA_END
	MOVLW	'~'
	XORWF	OUT,W
	BTFSC	STATUS,Z
	GOTO	CHRA_END
	MOVLW	07FH
	XORWF	OUT,W
	BTFSC	STATUS,Z
	GOTO	CHRA_END
	MOVLW	B'00100000'
	SUBWF	OUT,F
	GOTO	CHRA_END
MAIN
	BSF		STATUS,RP0
	BCF		INTCON,GIE
	CLRF	TRISA
	MOVLW	0FH
	MOVWF	TRISB
	BCF		OPTION_REG,INTEDG
	BCF		STATUS,RP0
	BSF		PORTB,1
	BSF		INTCON,GIE
	BSF		INTCON,INTE		
MAINLP
	GOTO    MAINLP		
;RA4-TxD
CSEND
	MOVWF	IN
	MOVLW	08H
	MOVWF	CNTB
	BCF		PORTA,4
	CALL	TIME104
CSENDLP
	BTFSC	IN,0
	BSF		PORTA,4
	BTFSS	IN,0
	BCF		PORTA,4
	CALL	TIME104
	RRF		IN,F
	DECFSZ	CNTB,F
	GOTO	CSENDLP
	BSF		PORTA,4
	CALL	TIME104
	RETURN
;RB0-RxD
CRECV
	CLRF	TMPA
	MOVLW	08H
	MOVWF	CNTB
	CALL	TIME156
CRECVLP
	BTFSC	PORTB,0
	BSF		STATUS,C
	BTFSS	PORTB,0
	BCF		STATUS,C
	RRF		TMPA,F
	CALL	TIME104
	DECFSZ	CNTB,F
	GOTO	CRECVLP
	MOVF	TMPA,W
	RETURN
TIME156
	MOVLW	0C3H
	MOVWF	CNT1
LOOP1
	NOP
	DECFSZ	CNT1,F
	GOTO	LOOP1
	RETURN
TIME104
	MOVLW	082H
	MOVWF	CNT1
LOOP2
	NOP
	DECFSZ	CNT1,F
	GOTO	LOOP2
	RETURN
END

