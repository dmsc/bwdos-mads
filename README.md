Modernized BW-DOS Sources
-------------------------

This repository contains "modernized" sources of BW-DOS, converted from the
original to MADS assembly syntax and with modifications by DMSC and HolgerJanz.

There is a makefile to assemble all sources, just type `make` to generate all
the bianry files in the `build/disk` folder and build and a disk image using
the `mkatr` tool.


Description of the files
========================

DOS Sources, those are assembled using the ASM file that includes all the parts:

    dos/bwdos.asm
      dos/bwdosa.src
      dos/bwdosb.src
      dos/bwdosc.src
      dos/bwmac.src
      dos/comtab.src

Standard tools, those are assembled directly:

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

The following utilities are multi-part sources, and must be assembled with the
stub that includes all parts:

    utils/backup.asm
      utils/bk_a.src
      utils/bk_b.src

    utils/menu.asm
      utils/menu_a.src
      utils/menu_b.src
      utils/menu_c.src

