BW-DOS Original Sources
-----------------------

This repository contains the sources of BW-DOS version 1.30, converted to MADS
assembly syntax.

This is a work in progress, currently the converted files are:

    dos/bwdosa.src
    dos/bwdosb.src
    dos/bwdosc.src
    dos/bwmac.src
    dos/comtab.src
	utils/dirmast.src
	utils/disass.src
	utils/dump.src
	utils/else.src
	utils/endif.src
	utils/format.src
	utils/hexedit.src
	utils/if.src
	utils/mdump.src
	utils/mem.src
	utils/memedit.src
	utils/move.src
	utils/msdos.src
	utils/msini.src
	utils/newed.src
	utils/offload.src
	utils/pause.src
	utils/save.src
	utils/time.src
	utils/unerase.src
	utils/verify.src
	utils/xbat.src


Note that some of the utilities are "protected" by exor-ing  part of the code,
so those can´t be assembled directly from source.

