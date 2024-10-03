# CS 218 Assignment #7
# Simple make file for asst #7

OBJS	= ast7.o
ASM	= yasm -g dwarf2 -f elf64
LD	= ld -g

all: ast7

ast7.o: ast7.asm 
	$(ASM) ast7.asm -l ast7.lst

ast7: ast7.o
	$(LD) -o ast7 $(OBJS)

# -----
# clean by removing object file.

clean:
	rm  $(OBJS)
	rm  ast7.lst

