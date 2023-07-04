
* Default DATE and TIME
DEFDAY	EQU	28
DEFMON	EQU	11
DEFYEA	EQU	95
DEFHOU	EQU	22
DEFMIN	EQU	14
DEFSEC	EQU	06

	ICL	"equates.inc"
	ICL	"bwmac.src"
	ICL	"bwdosa.src"
	ICL	"bwcmd.src"
	ICL	"bwdosb.src"
	ICL	"bwdosc.src"

	ICL	"comtab.src"

* ENTRY: Copy to run address and start
ENTRY	CLD

	LDX	#0
	LDY	#$20

ENTRY1	LDA	START+$3000,X
ENTRY2	STA	START,X
	INX
	BNE	ENTRY1

	INC	ENTRY1+$3002
	INC	ENTRY2+$3002

	DEY
	BNE	ENTRY1

	JMP	SRCHNAM

	RUN	ENTRY+$3000
