# makefile for nesdoug example code, for Linux
# this version won't move the final files to BUILD folder
# also won't rebuild on changes to neslib/nesdoug/famitone files
# makefile with BUILD folder support (safe clean)
# Makefile with selective cleaning

CC65 = cc65
CA65 = ca65
LD65 = ld65
NAME = hello
CFG = nrom_32k_vert.cfg
BUILD_DIR = BUILD

.PHONY: default clean

default: $(BUILD_DIR)/$(NAME).nes

$(BUILD_DIR)/$(NAME).nes: $(BUILD_DIR)/$(NAME).o $(BUILD_DIR)/crt0.o
	$(LD65) -C $(CFG) -o $@ $^ nes.lib -Ln $(BUILD_DIR)/labels.txt --dbgfile $(BUILD_DIR)/dbg.txt
	@echo "✅ $(NAME).nes created in $(BUILD_DIR)/"

$(BUILD_DIR)/%.o: $(BUILD_DIR)/%.s
	$(CA65) $< -o $@

$(BUILD_DIR)/$(NAME).s: $(NAME).c
	@mkdir -p $(BUILD_DIR)
	$(CC65) -Oi $< --add-source -o $@

$(BUILD_DIR)/crt0.o: crt0.s Alpha.chr
	@mkdir -p $(BUILD_DIR)
	$(CA65) $< -o $@

clean:
	@echo "🧹 Cleaning only compilation artifacts..."
	@rm -fv $(BUILD_DIR)/$(NAME).nes \
	         $(BUILD_DIR)/$(NAME).s \
	         $(BUILD_DIR)/$(NAME).o \
	         $(BUILD_DIR)/crt0.o
	@echo "✔️ Kept all other files in $(BUILD_DIR)/"