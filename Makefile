# BW-DOS build recipes
# --------------------

# Build folder
BUILD=build

# Output disk
DISK=$(BUILD)/disk

# Standard tools:
TOOLS=\
      dos/bload.com\
      dos/boot.com\
      dos/chkdsk.com\
      dos/chvol.com\
      dos/copy.com\
      dos/cut.com\
      dos/date.com\
      dos/dirmast.com\
      dos/disass.com\
      dos/dump.com\
      dos/else.com\
      dos/endif.com\
      dos/format.com\
      dos/hexedit.com\
      dos/if.com\
      dos/mdump.com\
      dos/mem.com\
      dos/memedit.com\
      dos/move.com\
      dos/msdos.com\
      dos/msini.com\
      dos/newed.com\
      dos/offload.com\
      dos/pause.com\
      dos/save.com\
      dos/time.com\
      dos/unerase.com\
      dos/verify.com\
      dos/xbat.com\
      dos/argsprn.com\
      dos/argsrtc.com\
      dos/autocwd.com\
      dos/clock.com\
      dos/dosdrive.com\
      dos/keybuff.com\
      dos/rambox.com\
      dos/ramdisk.com\
      dos/rtime8.com\
      dos/xfsio.com\
      dos/xlrdisk.com\

# Tools from multiple files
TOOLS_MULTI=\
      dos/backup.com\
      dos/menu.com\

# And the main DOS file
XDOS=dos/xbw14d.dos

# The extra files included in the original BW-DOS disk:
EXTRA=\
      readme.txt\
      startup.bat\
      bwdfunct.bas\

# The resulting ATR image
ATR=bwdos.atr

#######################################################################
# Build tools
MADS=mads
MKATR=mkatr

#######################################################################
# Main rules

# The output files
O_TOOLS=$(TOOLS:%=$(DISK)/%)
O_TOOLS_MULTI=$(TOOLS_MULTI:%=$(DISK)/%)
O_XDOS=$(XDOS:%=$(DISK)/%)
O_EXTRA=$(EXTRA:%=$(DISK)/%)
O_ATR=$(ATR:%=$(BUILD)/%)

OUT=\
    $(O_TOOLS)\
    $(O_TOOLS_MULTI)\
    $(O_XDOS)\
    $(O_EXTRA)\

# Main rule: build the ATR image
all: $(O_ATR)

# Build boot-able DOS disk image
$(O_ATR): $(OUT) | $(BUILD)
	$(MKATR) $@ $(DISK)/dos -b $(O_XDOS) \
		$(sort $(O_TOOLS) $(O_TOOLS_MULTI) $(O_EXTRA))

# Build DOS
$(O_XDOS):dos/bwdos.asm | $(DISK)/dos
	$(MADS) -o:$@ $<

# Simple assembly for the main tools:
$(O_TOOLS):$(DISK)/dos/%.com:utils/%.src | $(DISK)/dos
	$(MADS) -o:$@ $<

# Assembly from multiple files:
$(O_TOOLS_MULTI):$(DISK)/dos/%.com:utils/%.asm | $(DISK)/dos
	$(MADS) -o:$@ $<

# Extra files
$(O_EXTRA):$(DISK)/%:extra/%
	cp $< $@

# Make build folder
$(BUILD):
	mkdir -p $@

$(DISK): | $(BUILD)
	mkdir -p $@

$(DISK)/dos: | $(DISK)
	mkdir -p $@

# Dependencies
$(O_XDOS): dos/bwdosa.src dos/bwdosb.src dos/bwdosc.src dos/bwmac.src\
           dos/comtab.src dos/bwcmd.src dos/equates.inc dos/startup.src
