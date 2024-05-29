#
#
#
#################################################################
#	�R���p�C���� MinGw gcc���g�p���܂��B
#################################################################
# REMOVE DEFAULT MAKE RULE
MAKEFLAGS = -r

.SUFFIXES:

.SUFFIXES:	.c .o

.PHONY: all0 moni3 run asmpp nybbles

#
# Default Target
#
all0:	moni3
all1:	nybbles
all3:	nibl3

#============================
# DOS���ǂ����`�F�b�N.
 ifdef ComSpec
MSDOS=1
 endif

 ifdef COMSPEC
MSDOS=1
 endif
#============================

 ifdef MSDOS
DOSFLAGS = -D_MSDOS_ -std=c99
EXE = .exe
WIN32LIB= -lkernel32 -luser32 -lgdi32 -lsetupapi 
 else
DOSFLAGS = -D_LINUX_
EXE =
WIN32LIB= 
 endif
#CFLAGS = -Wall -pedantic -g3 -Werror

CFLAGS = -Wall -O3 $(DOSFLAGS)

moni3:	asmpp
	asmpp3/asmpp3.exe -S moni3.m
	asl -L moni3.asm
	p2bin  moni3.p
	cat    moni3.lst

run:	nybbles.exe
	./nybbles.exe -r moni3.bin -d 7     2>trace.log


asmpp:
	make -C asmpp3
#
# Test (SC/MP-III)
#
tr:
	./nybbles -d 7   2>trace.log

trace:
	./nybbles -d 7   2>trace.log

test:	nibl3
	./nybbles


#
# Test (SC/MP-II)
#
test2:
	./scmp2 -r NIBL.bin 

debug2:
	./scmp2 -r NIBL.bin -d 7





nybbles.exe: nybbles.o ns807x.o
	gcc -g3 nybbles.o ns807x.o -o nybbles.exe

scmp2:	scmp2.o ns806x.o debug.o
	gcc -g3 scmp2.o ns806x.o debug.o -o scmp2

nibl3:
	asl -L nibl3.asm
	p2bin nibl3.p
	p2hex nibl3.p
	xdump nibl3.bin >nibl3.dmp



clean:
	make -C asmpp3 clean
	-rm *.o
	-rm *~
	-rm err
	-rm nybbles.exe


SRCS := $(subst ./,,$(shell find . -name '*.c'))
DEPDIR := .deps
# DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d
CC = gcc

COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c

#%.o : %.c
#%.o : %.c $(DEPDIR)/%.d | $(DEPDIR)

%.o : %.c
	$(COMPILE.c) $(OUTPUT_OPTION) $<

# $(DEPDIR): ; @mkdir -p $@

# DEPFILES := $(SRCS:%.c=$(DEPDIR)/%.d)
# $(DEPFILES):


# // include $(wildcard $(DEPFILES))
