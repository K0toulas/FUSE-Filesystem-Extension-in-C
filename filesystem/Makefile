all:
	gcc -Wall -g -D_FILE_OFFSET_BITS=64 bbfs.c log.c  -o bbfs -lssl -lcrypto -lfuse
	mkdir -p ../example/mountdir ../example/rootdir
clean:
	rm -rf bbfs log.o library.o ../example