CC = gcc
LD = gcc
NASM = nasm 

CFLAGS = -c -m32 -O3 -std=gnu99
LFLAGS = -m32
NASMFLAGS = -f elf -F stabs

PROG = branch

OBJS = asm.o $(PROG).o

default: $(PROG)

$(PROG): $(OBJS) 
	$(LD) $(LFLAGS) $(OBJS)  -o $(PROG)

asm.o: asm.asm
	$(NASM) $(NASMFLAGS) asm.asm

$(PROG).o: $(PROG).c
	$(CC) $(CFLAGS) $(PROG).c

clean:
	 rm -rf *.o $(PROG) *~

