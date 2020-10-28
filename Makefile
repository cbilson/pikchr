CC = gcc
MINGW_CC = x86_64-w64-mingw32-gcc-10-win32
CFLAGS = -O0 -g -Wall -Wextra
LIBS = -lm

all:	pikchr win-64

update-tools: win-64
	cp pikchr.exe $(WIN_HOME)/OneDrive/Tools/

pikchr:	pikchr.c
	$(CC) $(CFLAGS) -DPIKCHR_SHELL pikchr.c -o pikchr $(LIBS)

win-64: pikchr.c
	$(MINGW_CC) $(CFLAGS) -DPIKCHR_SHELL pikchr.c -o pikchr.exe $(LIBS)

pikchrfuzz:	pikchr.c
	clang -g -O3 -fsanitize=fuzzer,undefined,address -o pikchrfuzz \
	  -DPIKCHR_FUZZ pikchr.c $(LIBS)

pikchr.c:	pikchr.y pikchr.h.in lempar.c lemon
	./lemon pikchr.y
	cat pikchr.h.in >pikchr.h

lemon:	lemon.c
	$(CC) $(CFLAGS) lemon.c -o lemon

test:	pikchr
	./pikchr */*.pikchr >out.html || true
	open out.html

clean:	
	rm -f pikchr pikchr.c pikchr.h pikchr.out lemon out.html

