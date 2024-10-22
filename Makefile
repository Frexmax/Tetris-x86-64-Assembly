tetris:
	gcc -no-pie -g -o tetris tetris.s -lraylib -lGL -lm -lpthread -ldl -lrt -lX11

play:
	./tetris

clean:
	rm -f tetris
