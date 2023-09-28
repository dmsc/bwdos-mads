
* Default DATE and TIME
DEFDAY	EQU	28
DEFMON	EQU	11
DEFYEA	EQU	95
DEFHOU	EQU	22
DEFMIN	EQU	14
DEFSEC	EQU	06

* Load address
LOADAD	EQU	$1C00

	ICL	"equates.inc"
	ICL	"bwmac.src"
	ICL	"bwdosa.src"
	ICL	"bwcmd.src"
	ICL	"bwdosb.src"
	ICL	"bwdosc.src"
	ICL	"startup.src"

	ICL	"comtab.src"

