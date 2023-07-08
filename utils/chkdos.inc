*Check DOS is Sparta compatible

START	LDA	$700
	CMP	#'S'
	BEQ	START2

	JSR	PRINT
	DTA	155,253
	DTA	C"Incorrect DOS version"
	DTA	155,0

	JMP	(10)
START2
