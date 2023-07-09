*Show ERROR and number

ERROR	TYA
	PHA

	JSR	PRINT
	DTA 155
	DTA C"Error "
	DTA 0

	LDX	#2

ERR2	LDY	#$2F
	PLA

ERR4	PHA
	SEC
	SBC	ERRTAB,X
	INY
	BCS	ERR4
**
	TXA
	PHA

	TYA
	JSR	PRT1

	PLA
	TAX

	DEX
	BPL	ERR2

*NOTE: we miss a PLA here, but the code will just jump to DOS
*      after this, so we will skip that byte.

**
	LDA	#$9B
	JSR	PRT1
