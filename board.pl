board([[s,s,s],
		[s,s,s],
		[s,s,s]]).

display_board([L1|Ls],X,Y):- 
	display_line(L1),
	nl,
	write('-|-|-'),
	nl,
	display_board(Ls,X,Y).

display_board([],X,Y):-
	nl,
	write('player1: '),
	write(X),
	nl,
	write('player2: '),
	write(Y),
	nl, nl.

display_line([E|Es]):-
	translate(E,V),
	write(V),
	write('|'),
	display_line(Es).
	
translate(s,' ').
translate(x,'X').
translate(o, 'O').

display_line([]).

read_player(X):-
	write('player name: '),
	read(X),
	nl.

play_game(B,X,Y):-
	board(B),
	read_player(X),
	read_player(Y),
	nl,
	nl,
	display_board(B,X,Y).
	