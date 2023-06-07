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
	utils/bload.src
	utils/boot.src
	utils/chkdsk.src
	utils/chvol.src
	utils/copy.src
	utils/cut.src
	utils/date.src
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

The following utilities are multi-part sources, and must be assembled with the
stub that includes all parts:

    utils/backup.asm
      utils/bk_a.src
      utils/bk_b.src

    utils/menu.asm
      utils/menu_a.src
      utils/menu_b.src
      utils/menu_c.src

Note that some of the utilities are "protected" by exor-ing  part of the code,
so those can´t be assembled directly from source:

    utils/argsprn.src
    utils/argsrtc.src
    utils/autocwd.src
    utils/clock.src
    utils/dosdrive.src
    utils/keybuff.src
    utils/rambox.src
    utils/ramdisk.src
    utils/rtime8.src
    utils/xfsio.src
    utils/xlrdisk.src

