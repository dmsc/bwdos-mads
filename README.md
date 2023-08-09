Optimized BW-DOS by DMSC
========================

This is a fork of the original BW-DOS sources, converted to MADS assembly
syntax and with modifications by HolgetJanz and DMSC.

The main changes from BW-DOS 1.3 to this sources are described bellow.

There is a makefile to assemble all sources, just type `make` to generate all
the bianry files in the `build/disk` folder and build and a disk image using
the `mkatr` tool.

Changes from BW-DOS 1.3
-----------------------

### Changes to the resident DOS and command processor

* Reduced memory usage: new version has `MEMLO` at $1E9D, 43 bytes less than
  the original. Also, the disk file is 181 bytes shorter.

* Modern syntax for the commands.

  Internal commands are renamed to modern ones,

| Original  | New    |
| --------- | ------ |
| RENAME    | REN    |
| ERASE     | DEL    |
| PROTECT   | PROT   |
| UNPROTECT | UNPROT |
| CREDIR    | MD     |
| DELDIR    | RD     |
| CWD       | CD     |
| LOAD      | LOAD   |
| CAR       | CAR    |
| RUN       | RUN    |
| PRINT     | PRINT  |
| TYPE      | TYPE   |
| DIR       | DIR    |
| DIRS      | DIRS   |
| BASIC     | BASIC  |

* Adds `MAN` command, same as `TYPE`, allows reading on-line documentation.

* Always disable BASIC on startup for the XL/XE computers, so it boots directly
  to the command processor if no external cartridge is present. This means that
  you need to type `BASIC ON` and then `CAR` to run BASIC.

* Move `COMTAB` to page 7, at absolute address $726. This allows programs
  specifically written for BW-DOS 1.4 or newer to call the API directly.

* Size optimizations in many areas, obfuscation in the binaries removed and
  simplified the loader.

* The version is shown as 1.4D, 1.4 is the modifications by HolgetJanz.

* Fixed some minor bugs:
  * Improve performance of sector allocation for overwrite cases.
  * Don´t accept `@` as `9` when parsing hexadecimal numbers.
  * Avoid screen corruption when enabling BASIC.

### Optimization to the resident commands

Many of the external commands are reduced in size, both in disk and in the
resident size after installation, for example, `RAMDISK` now only uses 31 bytes
of low RAM and `XFSIO` only 103.

| Command   | Original Size / Resident | New Size / Resident |
| --------- | ------------------------ | ------------------- |
| ARGSPRN   |        1484   /  158     |   1446   /   158    |
| ARGSRTC   |        1388   /  270     |   1346   /   270    |
| AUTOCWD   |         731   /   74     |    639   /    74    |
| CLOCK     |        1069   /  210     |    821   /   151    |
| DOSDRIVE  |         986   /  108     |    876   /    70    |
| KEYBUFF   |        1066   /  278     |    825   /   183    |
| RAMBOX    |        1746   /   34     |   1658   /    34    |
| RAMDISK   |        2165   /   73     |   2021   /    31    |
| RTIME8    |        1316   / 94 (213) |   1120   / 91 (199) |
| XFSIO     |        1074   /  115     |    925   /   101    |
| XLRDISK   |        1341   /   73     |   1274   /    31    |

### Optimization to the external commands

Many of the external commands are reduced in size:

| Command   | Original Size | New Size |
| --------- | ------------- | -------- |
| BACKUP    |     4617      |   4611   |
| BLOAD     |      487      |    489   |
| BOOT      |      605      |    588   |
| CHKDSK    |      470      |    434   |
| CHVOL     |      344      |    310   |
| COPY      |     1306      |   1151   |
| CUT       |      702      |    698   |
| DATE      |      661      |    509   |
| DIRMAST   |     2682      |   2682   |
| DISASS    |     1603      |   1599   |
| DUMP      |      783      |    722   |
| ELSE      |      243      |    199   |
| ENDIF     |        9      |      9   |
| FORMAT    |     2784      |   2767   |
| HEXEDIT   |      728      |    724   |
| IF        |      442      |    333   |
| MDUMP     |      554      |    496   |
| MEM       |      620      |    503   |
| MEMEDIT   |      502      |    499   |
| MENU      |     9883      |   9695   |
| MOVE      |     1736      |   1719   |
| MSDOS     |     2310      |   2292   |
| MSINI     |     1916      |   1565   |
| NEWED     |      422      |    373   |
| OFFLOAD   |      935      |    934   |
| PAUSE     |      273      |    250   |
| SAVE      |      466      |    381   |
| TIME      |      659      |    511   |
| UNERASE   |     1524      |   1442   |
| VERIFY    |      227      |    197   |
| XBAT      |      315      |    298   |

### Extra external commands

Currently, the new external commands are:

* `PWD`: shows the current (default) path in the given drive.

