CC = gcc
LD = gcc

CFLAGS = -c -m32 -O3 -std=gnu99
LFLAGS = -m32

PROG = restrict

OBJS = $(PROG).o

default: $(PROG)

$(PROG): $(OBJS) 
	$(LD) $(LFLAGS) $(OBJS)  -o $(PROG)

$(PROG).o: $(PROG).c
	$(CC) $(CFLAGS) $(PROG).c

clean:
	 rm -rf *.o $(PROG) *~

