

	ICL	"bwmac.src"
	ICL	"bwdosa.src"
	ICL	"bwcmd.src"
	ICL	"bwdosb.src"
	ICL	"bwdosc.src"

	ICL	"comtab.src"

* VSTUPNI INIT

VSTUPNI
	CLD

	LDX	#0
	LDY	#$20

VSTI1	LDA	ZACATEK+$3000,X
VSTI2	STA	ZACATEK,X
	INX
	BNE	VSTI1

	INC	VSTI1+$3002
	INC	VSTI2+$3002

	DEY
	BNE	VSTI1

	JMP	SRCHNAM

	RUN	VSTUPNI + $3000
