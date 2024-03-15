	LIST	P=PIC16F84A
	INCLUDE	"P16F84A.INC"
		
	__CONFIG    _HS_OSC&_WDT_OFF
		
CNT1	EQU	    0CH
CNT2	EQU	    0DH
CNT3	EQU	    0EH
CNT4	EQU	    0FH

	ORG	    0H

MAIN	
	BCF	    STATUS , C
	BSF	    STATUS , RP0
	CLRF	TRISB
	BCF	    STATUS , RP0
	MOVLW	B'00000001'
	MOVWF	PORTB
MAINLP	
	CALL    TIME125M
	MOVLW	007H
	MOVWF	CNT3
	CALL	LPSL
	CALL	TIME125M
	MOVLW	007H
	MOVWF	CNT3
	CALL	LPSR
	GOTO	MAINLP
LPSL
	CALL	TIME125M
	RLF		PORTB,	W
	MOVWF	PORTB
	DECFSZ	CNT3,	F
	GOTO	LPSL
	RETURN
LPSR
	CALL	TIME125M
	RRF		PORTB,	W
	MOVWF	PORTB
	DECFSZ	CNT3,	F
	GOTO	LPSR
	RETURN
TIME125U						
	MOVLW	0CFH			
	MOVWF	CNT1			
	NOP						
	NOP	
	NOP						
LOOP1
	DECFSZ	CNT1,F			
	GOTO	LOOP1			
	RETURN					
TIME0125M
	MOVLW	063H			
	MOVWF	CNT2		
LOOP2
	CALL	TIME125U
	NOP
	DECFSZ	CNT2,F	
	GOTO	LOOP2			
	RETURN					
TIME125M
	MOVLW	00AH			
	MOVWF	CNT4
LOOP3
	CALL	TIME0125M
	NOP
	DECFSZ	CNT4,F
	GOTO	LOOP3
	RETURN
END