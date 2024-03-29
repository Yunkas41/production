	LIST	P=PIC16F819
	#INCLUDE<P16F819.INC>
		
	__CONFIG    _HS_OSC & _CP_OFF & _WDT_OFF & _PWRTE_ON & _MCLR_ON & _LVP_OFF
		
CNT	EQU	020H
VAL	EQU	021H
CNT_VAL	EQU	022H
	
	ORG	0H
		
	
MAIN
	BSF		STATUS,RP0
	MOVLW	01H
	MOVWF	TRISA
	CLRF	TRISB
	MOVLW	0EH
	MOVWF	ADCON1
	BCF		STATUS,RP0
	MOVLW	081H
	MOVWF	ADCON0
	CLRF	VAL
	CLRF	CNT_VAL
	CLRF	PORTA
	CLRF	PORTB
	
ADSTART
	CLRF	CNT_VAL
	CALL	TIME20U
	BSF		ADCON0,GO
	
ADLOOP	
	BTFSC	ADCON0,GO
	GOTO	ADLOOP
	
	MOVF	ADRESH,W	
	MOVWF	VAL
	
	GOTO	OUTPUTCALC
;	GOTO	ADSTART
	
OUTPUTCALC	
	MOVLW	05H
	SUBWF	VAL,F
	
	BTFSS	STATUS,C
	GOTO	OUTPUT
	
	BTFSC	STATUS,Z
	GOTO	OUTPUT
	
	MOVF	CNT_VAL,W
	ADDLW	01H
	MOVWF	CNT_VAL
	
	GOTO	OUTPUTCALC
	
OUTPUT
	BSF		PORTA,1
	MOVF	CNT_VAL,W
	CALL	BCD
	MOVWF	PORTB
	GOTO	ADSTART
	
TIME20U
	MOVLW	020H
	MOVWF	CNT
	NOP

LOOP
	DECFSZ	CNT,F
	GOTO	LOOP
	RETURN
	
;BCD
BCD
	ANDLW	0FFH
	ADDWF	PCL,	F
	RETLW	00H			;code0
	RETLW	01H			;code1
	RETLW	02H			;code2
	RETLW	03H			;code3	
	RETLW	04H			;code4
	RETLW	05H			;code5
	RETLW	06H			;code6
	RETLW	07H			;code7
	RETLW	08H			;code8	
	RETLW	09H			;code9
	RETLW	10H			;code0
	RETLW	11H			;code1
	RETLW	12H			;code2
	RETLW	13H			;code3	
	RETLW	14H			;code4
	RETLW	15H			;code5
	RETLW	16H			;code6
	RETLW	17H			;code7
	RETLW	18H			;code8	
	RETLW	19H			;code9
	RETLW	20H			;code0
	RETLW	21H			;code1
	RETLW	22H			;code2
	RETLW	23H			;code3	
	RETLW	24H			;code4
	RETLW	25H			;code5
	RETLW	26H			;code6
	RETLW	27H			;code7
	RETLW	28H			;code8	
	RETLW	29H			;code9
	RETLW	30H			;code0
	RETLW	31H			;code1
	RETLW	32H			;code2
	RETLW	33H			;code3	
	RETLW	34H			;code4
	RETLW	35H			;code5
	RETLW	36H			;code6
	RETLW	37H			;code7
	RETLW	38H			;code8	
	RETLW	39H			;code9
	RETLW	40H			;code0
	RETLW	41H			;code1
	RETLW	42H			;code2
	RETLW	43H			;code3	
	RETLW	44H			;code4
	RETLW	45H			;code5
	RETLW	46H			;code6
	RETLW	47H			;code7
	RETLW	48H			;code8	
	RETLW	49H			;code9
	RETLW	50H			;code0
	RETLW	51H			;code1
	RETLW	52H			;code2
	RETLW	53H			;code3	
	RETLW	54H			;code4
	RETLW	55H			;code5
	RETLW	56H			;code6
	RETLW	57H			;code7
	RETLW	58H			;code8	
	RETLW	59H			;code9
	RETLW	60H			;code0
	RETLW	61H			;code1
	RETLW	62H			;code2
	RETLW	63H			;code3	
	RETLW	64H			;code4
	RETLW	65H			;code5
	RETLW	66H			;code6
	RETLW	67H			;code7
	RETLW	68H			;code8	
	RETLW	69H			;code9
	RETLW	70H			;code0
	RETLW	71H			;code1
	RETLW	72H			;code2
	RETLW	73H			;code3	
	RETLW	74H			;code4
	RETLW	75H			;code5
	RETLW	76H			;code6
	RETLW	77H			;code7
	RETLW	78H			;code8	
	RETLW	79H			;code9
	RETLW	80H			;code0
	RETLW	81H			;code1
	RETLW	82H			;code2
	RETLW	83H			;code3	
	RETLW	84H			;code4
	RETLW	85H			;code5
	RETLW	86H			;code6
	RETLW	87H			;code7
	RETLW	88H			;code8	
	RETLW	89H			;code9
	RETLW	90H			;code0
	RETLW	91H			;code1
	RETLW	92H			;code2
	RETLW	93H			;code3	
	RETLW	94H			;code4
	RETLW	95H			;code5
	RETLW	96H			;code6
	RETLW	97H			;code61
	RETLW	98H			;code62	
	RETLW	99H			;code63
		
END