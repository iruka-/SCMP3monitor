#
#
#
#CFLAGS = -Wall -pedantic -g3 -Werror

CFLAGS = -Wall -O3

.PHONY: all0 moni3 run asmpp
#
# Default Target
#
all0:	moni3
all1:	nybbles
all3:	nibl3

moni3:	asmpp
	asmpp3/asmpp3.exe -S moni3.m
	asl -L moni3.asm
	p2bin  moni3.p
	cat    moni3.lst

run:	nybbles
	./nybbles -r moni3.bin -d 7     2>trace.log


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





nybbles: nybbles.o ns807x.o
	cc -g3 nybbles.o ns807x.o -o nybbles

scmp2:	scmp2.o ns806x.o debug.o
	cc -g3 scmp2.o ns806x.o debug.o -o scmp2

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
	-rm nybbles


SRCS := $(subst ./,,$(shell find . -name '*.c'))
DEPDIR := .deps
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d

COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c

%.o : %.c
%.o : %.c $(DEPDIR)/%.d | $(DEPDIR)
	$(COMPILE.c) $(OUTPUT_OPTION) $<

$(DEPDIR): ; @mkdir -p $@

DEPFILES := $(SRCS:%.c=$(DEPDIR)/%.d)
$(DEPFILES):


# include $(wildcard $(DEPFILES))
