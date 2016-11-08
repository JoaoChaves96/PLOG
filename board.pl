:-consult(auxiliar).

board([ [q,q,d,s],
		[q,d,p,s],
		[d,p,p,s],
		[s,s,s,s],
		[s,s,s,s],
		[s,p,p,d],
		[s,p,d,q],
		[s,d,q,q]]).


display_board_letter(B):-
	write('    a   b   c   d'),
	nl,
	write('   --------------- '),
	nl.


%half_board(N):- ( N=4 -> write('  =================');write('   ---------------') ).


display_board([L1|Ls],X,Y,N):-
	display_line_number(N),
	N1 is N+1,
	write('|'),
	display_line(L1),
	nl,
	( N=4 -> write('  =================');write('   ---------------') ),
	nl,
	display_board(Ls,X,Y,N1).

display_board([],X,Y,_):-
	nl,
	write('player1: '),
	write(X),
	nl,
	write('player2: '),
	write(Y),
	nl, nl.

display_line_number(N):-
	write(N),
	write(' ').

display_line([E|Es]):-
	translate(E,V),
	write(' '),
	write(V),
	write(' |'),
	display_line(Es).
	
display_line([]).

	
translate(s,' ').
translate(p,'*').
translate(d, 'x').
translate(q, 'X').

read_player(X):-
	write('player name: '),
	read(X),
	nl.

ask_play(ColunaToMove, LinhaToMove, ColunaDestino, LinhaDestino, X, L1) :-
	write('Digite a coluna (letra) da peca a mover'), nl,
	getChar(ColunaToMove),
	letra(ColunaToMove, X, L1),
	write('Digite a linha (numero) da peca a mover'), nl,
	getDigit(LinhaToMove),
	numero(LinhaToMove, X, L1),
 	write('Digite a coluna (letra) do destino'), nl,
	getChar(ColunaDestino),
	letra(ColunaDestino, X, L1),
 	write('Digite a linha (numero) do destino'), nl,
	getDigit(LinhaDestino),
	numero(LinhaDestino, X, L1).




play_game(B,X,Y):-
	board(B),
	%read_player(X),
	%read_player(Y),
	nl,
	nl,
	display_board_letter(B),
	display_board(B,X,Y,1),
	getElement(B,1,1,K),	
	ask_play(S,I,O,R,X,L1).
