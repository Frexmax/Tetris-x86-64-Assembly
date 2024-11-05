tetris:
	gcc -no-pie -g -o tetris tetris.s -lraylib -lGL -lm -lpthread -ldl -lrt -lX11

play:
	./tetris

clean:
	rm -f tetris

reset_score:
	gcc -no-pie -g -o clean_scores scoring/clean_scores.s
	./clean_scores
	rm -f clean_scores
