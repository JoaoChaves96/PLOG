board([	[la,q,q,q,s],
		[lb,d,d,d,s],
		[lc,p,p,p,s],
		[ld,s,s,s,s],
		[le,s,s,s,s],
		[lf,s,p,p,p],
		[lg,s,d,d,d],
		[lh,s,q,q,q]]).

display_total_board([L1|Ls],X,Y):-
	write('   1 2 3 4'),
	nl,
	write('   - - - -'),
	nl,
	display_board([L1|Ls],X,Y).
	
display_board([L1|Ls],X,Y):- 
	display_line(L1),
	nl,
	write('   - - - -'),
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
translate(p,'P').
translate(d, 'D').
translate(q, 'Q').
translate(la,'a ').
translate(lb,'b ').
translate(lc,'c ').
translate(ld,'d ').
translate(le,'e ').
translate(lf,'f ').
translate(lg,'g ').
translate(lh,'h ').

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
	display_total_board(B,X,Y).
	