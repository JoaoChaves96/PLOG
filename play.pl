check_path_col(B, Nl, C, Nc, Inc):-
  Fc is Nc - Inc,
	(C = Fc -> write('path_col valido\n'), true;
	Next is C + Inc,
	getelem(B, Nl, Next, Elem),
	(Elem \= 's' -> write('path col invalido\n'), false; check_path_col(B, Nl, Next, Nc, Inc))).

check_path_line(B, L, Nl, Nc, Inc):-
  Fl is Nl - Inc,
	(L = Fl -> write('path_line valido\n'), true;
	Next is L + Inc,
	getelem(B, Next, Nc, Elem),
	(Elem \= 's' -> write('path line invalido\n'), false; check_path_line(B, Next, Nl, Nc, Inc))).


check_path_line_col(B, L, C, Nl, Nc, IncL, IncC):-
  Fl is Nl - IncL,
  Fc is Nc - IncC,
	(L = Fl, C = Fc -> write('path_line_col valido\n'), true;
	NextL is L + IncL,
	NextC is C + IncC,
	getelem(B, NextL, NextC, Elem),
	(Elem \= 's' -> write('path invalido\n'), false; check_path_line_col(B, NextL, NextC, Nl, Nc, IncL, IncC))).

check_jogada(B, L, C, Nl, Nc, J, Elem2, NewElem):-
  getelem(B, Nl, Nc, Elem2),
  (
    is_par(J) -> check_jogada2(B, J, L, C, Nl, Elem2, NewElem); check_jogada1(B, J, L, C, Nl, Elem2, NewElem)
  ).

check_jogada1(B, J, L, C, Nl, Elem, NewElem):-
  getelem(B, L, C, E),
  write('check jogada 1'), write(Elem), nl,
  (Elem = E, E = 'p', board_has_drones(B, J) -> NewElem = 'd', true;
  Elem = E, E = 'd', board_has_queens(B, J) -> NewElem = 'q', true;
  Elem = 's' -> NewElem = E, true;
  Elem \= 's', Nl < 5 -> NewElem = Elem, true;
  write('erro'), false).

check_jogada2(B, J, L, C, Nl, Elem, NewElem):-
  getelem(B, L, C, E),
  (Elem = E, E = 'p', board_has_drones(B, J) -> NewElem = 'd', true;
  Elem = E, E = 'd', board_has_queens(B, J) -> NewElem = 'q', true;
  Elem = 's' -> NewElem = E, true;
  Elem \= 's', Nl > 4 -> NewElem = E, true;
  write('erro'),false).

pawn_can_move(B,L,C,Nl,Nc, J, Elem2, NewElem):-
  (check_jogada(B, L, C, Nl, Nc, J, Elem2, NewElem) ->
	DL is abs(Nl-L),
	DC is abs(Nc-C),
	(DC=1,DL=1 -> nl ; (write('Jogada invalida_pawn\n') ,false)); write('fail check jogada'), false).

drone_can_move(B,L,C,Nl,Nc, J, Elem2, NewElem):-
  (check_jogada(B, L, C, Nl, Nc, J, Elem2, NewElem) ->
	AbsDL is abs(Nl-L),
	AbsDC is abs(Nc-C),
	DL is Nl-L,
	DC is Nc-C,
	(AbsDC=0,AbsDL=0 ->  (write('Jogada invalida_drone\n') ,false );
	((AbsDL=1 ;AbsDL=2),AbsDC=0 );((AbsDC=1;AbsDC=2),AbsDL=0) -> nl;  write('Jogada invalida_drone\n'),false),

	(
		DL = 0, DC < 0 -> check_path_col(B, Nl, C, Nc, -1);
		DL = 0, DC > 0 -> check_path_col(B, Nl, C, Nc, 1);

		DC = 0, DL < 0 -> check_path_line(B, L, Nl, Nc, -1);
		DC = 0, DL > 0 -> check_path_line(B, L, Nl, Nc, 1);
		nl
	); false).

queen_can_move(B, L, C, Nl, Nc, J, Elem2, NewElem):-
  (check_jogada(B, L, C, Nl, Nc, J, Elem2, NewElem) ->
	DL is Nl-L,
	DC is Nc-C,
	(
		DC=0,DL=0 -> write('Jogada invalida_queen\n') , false;

		DL = 0, DC < 0 -> check_path_col(B, Nl, C, Nc, -1);
		DL = 0, DC > 0 -> check_path_col(B, Nl, C, Nc, 1);

		DC = 0, DL < 0 -> check_path_line(B, L, Nl, Nc, -1);
		DC = 0, DL > 0 -> check_path_line(B, L, Nl, Nc, 1);

	AbsL is abs(DL),
	AbsC is abs(DC),

	(AbsL \= AbsC -> write('Jogada invalida abs_queen\n'), false; nl),

	(
		DL < 0, DC < 0 -> check_path_line_col(B, L, C, Nl, Nc, -1, -1);
		DL < 0, DC > 0 -> check_path_line_col(B, L, C, Nl, Nc, -1, 1);
		DL > 0, DC < 0 -> check_path_line_col(B, L, C, Nl, Nc, 1, -1);
		DL > 0, DC > 0 -> check_path_line_col(B, L, C, Nl, Nc, 1, 1);
		nl
	)
  );
  false).

end_game_p1(B, C):-
	C = 5 -> true;
	nth1(C, B, Elem),
	(
	Elem \= ['s', 's', 's', 's'] -> false;
	C1 is C + 1,
	end_game_p1(B, C1)).

end_game_p2(B, C):-
	C = 9 -> true;
	nth1(C, B, Elem),
	(
		Elem \= ['s', 's', 's', 's'] -> false;

  	C1 is C + 1,
  	end_game_p2(B, C1)).

move_piece(B,L,C,Nl,Nc,Nr, J, Os1, Ns1, Os2, Ns2):-
	getelem(B,L,C,Elem),
  write('prev: '), write(Elem),
  nl,
  getelem(B, Nl, Nc, Elem21),
  write('next: '), write(Elem21),
  nl,
	(
		Elem = 's' -> write('peca invalida\n'), false;
		Elem = 'p' -> F is 0;
		Elem = 'd' -> F is 1;
		Elem = 'q' -> F is 2
	),

		Li is L - 1,
		Ci is C - 1,

		NLi is Nl - 1,
		NCi is Nc - 1,

	(
		F = 0 -> (pawn_can_move(B, L, C, Nl, Nc, J, Elem3, NewElem) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(NLi, Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,NewElem, Nr); false);
		F = 1 -> (drone_can_move(B, L, C, Nl, Nc, J, Elem3, NewElem) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(NLi, Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,NewElem, Nr); false);
		F = 2 -> (queen_can_move(B, L, C, Nl, Nc, J, Elem3, NewElem) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(NLi, Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,NewElem, Nr); false)
	).

move_piece_PC(B,L,C,Nl,Nc,Nr, J, Os1, Ns1, Os2, Ns2):-
	getelem(B,L,C,Elem),
	(
		Elem = 's' -> write('peça invalida\n');
		Elem = 'p' -> F is 0;
		Elem = 'd' -> F is 1;
		Elem = 'q' -> F is 2
	),

		Li is L - 1,
		Ci is C - 1,

		NLi is Nl - 1,
		NCi is Nc - 1,

	(
		F = 0 -> (pawn_can_move(B, L, C, Nl, Nc, J, Elem3, NewElem) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(NLi, Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,NewElem, Nr); false);
		F = 1 -> (drone_can_move(B, L, C, Nl, Nc, J, Elem3, NewElem) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(NLi, Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,NewElem, Nr); false);
		F = 2 -> (queen_can_move(B, L, C, Nl, Nc, J, Elem3, NewElem) -> replace(B, Li, Ci, 's', N), getelem(B, Nl, Nc, Elem2), update_score(NLi, Elem2, Os1, Ns1, Os2, Ns2, J), replace(N,NLi, NCi,NewElem, Nr); false)
	).

move(L, _, J, S1, Ns1, S2, Ns2):-
	(is_par(J) ->  L < 5, Ns1 is S1; L > 4, Ns2 is S2).

make_play_vs_PC(B, X, Y, S1, S2, Fs1, Fs2, J):-
	nl,
	write('player1 score: '),write(S1), Ns1 is S1,
	nl,
	write('player2 score: '),write(S2), Ns2 is S2,
	nl,
	nl,
	(
		is_par(J) -> get_rand_piece(B, Nb, J, S1, Ns1, S2, Ns2); printPlayerTurn(J), nl, nl, ask_play(B, Nb, J, S1, Ns1, S2, Ns2)
	),
	clearScreen,
	display_full_board(Nb, X, Y),
	J1 is J + 1,
	((end_game_p2(Nb, 5); end_game_p1(Nb, 1)) ->
		clearScreen,
		display_full_board(Nb, X, Y),
		nl,
		printGameOver,
		nl,
		nl,
		Fs1 is Ns1, Fs2 is Ns2;
	  make_play_vs_PC(Nb, X, Y, Ns1, Ns2, Fs1, Fs2, J1)).

make_play(B, X, Y, S1, S2, Fs1, Fs2, J):-
	nl,
	write(X), write(' score: '),write(S1),
	nl,
	write(Y), write(' score: '),write(S2),
	nl,
	nl,
	printPlayerTurn(J), nl, nl,
	ask_play(B, Nb, J, S1, Ns1, S2, Ns2),
	clearScreen,
	display_full_board(Nb, X, Y),
	J1 is J + 1,
	nl,
	((end_game_p2(Nb, 5); end_game_p1(Nb, 1)) ->
		clearScreen,
		display_full_board(Nb, X, Y),
		nl,
		printGameOver,
		nl,
		nl,
		Fs1 is Ns1, Fs2 is Ns2;
		make_play(Nb, X, Y, Ns1, Ns2, Fs1, Fs2, J1)).

play(B, X, Y):-
	getChar(_),
	nl,
	play_game(B, X, Y),
	make_play(B, X, Y, 0, 0, Fs1, Fs2, 1),
	compare_scores(Fs1, Fs2, 0),
	mainMenu.

play_vs_PC(B, X, Y):-
	Y = 'Computer',
  display_full_board(B, X, Y),
	nl,
	make_play_vs_PC(B, X, Y, 0, 0, Fs1, Fs2, 1),
	compare_scores(Fs1, Fs2, 1),
	mainMenu.
