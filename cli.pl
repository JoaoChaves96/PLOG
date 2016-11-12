:- include('board.pl').
:- include('auxiliar.pl').
:- include('computer.pl').

%%%%%%%%%%%ClearScreen%%%%%%%%%%%%%%%%%%

clearScreen :-
		printBlank(65).

printBlank(A) :-
			A > 0,
			nl,
			A1 is A - 1,
			printBlank(A1).

printBlank(_).

mainMenu :-
		clearScreen,
		printMainMenu,
		get_char(In),
		(
			In = '1' -> write('Chose to play\n'), playMenu;
			In = '2' -> write('Chose Instructions\n'), instructionsMenu;
			In = '3' -> write('Chose Exit\n');
			mainMenu
		).

printMainMenu :-

			write('##############################\n'),  %30 spaces
			write('#                            #\n'),
			write('#        Martian Chess       #\n'),
			write('#                            #\n'),
			write('##############################\n'),
			write('##############################\n'),
			write('#                            #\n'),
			write('#    1 - Play                #\n'),
			write('#    2 - Instructions        #\n'),
			write('#    3 - Exit                #\n'),
			write('#                            #\n'),
			write('##############################\n'),
			printBlank(20).


playMenu :-
		clearScreen,
		printPlayMenu,
		get_char(In),
		(
			In = '1' -> play(B, X, Y);
			In = '2' -> play_vs_PC(B, X, Y);
			In = '3' -> play_vs_PC(B, X, Y);
			playMenu
		),
		mainMenu.

printPlayMenu:-
	write('##############################\n'),
	write('#                            #\n'),
	write('# Chose a mode:              #\n'),
	write('#                            #\n'),
	write('#  1 - Player vs Player      #\n'),
	write('#  2 - Player vs Computer    #\n'),
	write('#  3 - Computer vs Computer  #\n'),
	write('#                            #\n'),
	write('##############################\n'),
	printBlank(20).

instructionsMenu :-
			clearScreen,
			printInstructionsMenu,
			get_char(_),
			get_char(_),
			mainMenu.


printInstructionsMenu :-
			write('######################################################\n'),
			write('#                                                    #\n'),
			write('#                                                    #\n'),
			write('#            Martian Chess - Instructions            #\n'),
			write('#                                                    #\n'),
			write('#                                                    #\n'),
			write('######################################################\n'),
			write('#                                                    #\n'),
			write('#                                                    #\n'),
			write('#    Martian Chess is a chess-like strategy gme in   #\n'),
			write('#   which location determines which pieces you can   #\n'),
			write('#   can move. Like Chess, each typee of piece has    #\n'),
			write('#   its own way of moving, and you can capture by    #\n'),
			write('#   moving onto an opponent`s square; but, unlike    #\n'),
			write('#   Chess, you can only move pieces placed in your   #\n'),
			write('#   own quadrant, and only attack those in other     #\n'),
			write('#   quadrants which may include your own former      #\n'),
			write('#   pieces. The game ends when someone runs out of   #\n'),
			write('#   pieces, and the winner is the player who has     #\n'),
			write('#   captured the most points.                        #\n'),
			write('#                                                    #\n'),
			write('#                                                    #\n'),
			write('######################################################\n'),
			printBlank(10).


printPlayer1Turn:-
	write('########################################\n'),
	write('#            Player 1 Turn             #\n'),
	write('########################################\n').

printPlayer2Turn:-
	write('########################################\n'),
	write('#            Player 2 Turn             #\n'),
	write('########################################\n').

printGameOver:-
	write('########################################\n'),
	write('#                                      #\n'),
	write('#              Game Over!              #\n'),
	write('#                                      #\n'),
	write('########################################\n').

printPlayer1Win:-
	write('########################################\n'),
	write('#                                      #\n'),
	write('#           Player 1 Wins!!            #\n'),
	write('#                                      #\n'),
	write('########################################\n').

printPlayer2Win:-
	write('########################################\n'),
	write('#                                      #\n'),
	write('#           Player 2 Wins!!            #\n'),
	write('#                                      #\n'),
	write('########################################\n').

printComputerWin:-
	write('########################################\n'),
	write('#                                      #\n'),
	write('#           Computer Wins!!            #\n'),
	write('#                                      #\n'),
	write('########################################\n').

printPlayerTurn(J):-
	(is_par(J) -> printPlayer2Turn; printPlayer1Turn).

compare_scores(Fs1, Fs2, F):-
	(Fs1 > Fs2 -> printPlayer1Win; (F = 1 -> printComputerWin;printPlayer2Win)),
	getChar(_).

make_play_vs_PC(B, X, Y, S1, S2, Fs1, Fs2, J):-
	nl,
	write('player1 score: '),write(S1), Ns1 is S1,
	nl,
	write('player2 score: '),write(S2), Ns2 is S2,
	nl,
	nl,
	(
		is_par(J) -> get_rand_piece(B, L, C, Nl, Nc, Nb, J, S1, Ns1, S2, Ns2); printPlayerTurn(J), nl, nl, ask_play(B, L, C, Nl, Nc, Nb, J, S1, Ns1, S2, Ns2)
	),
	clearScreen,
	display_full_board(Nb, X, Y, 1),
	J1 is J + 1,
	((end_game_p2(Nb, 5); end_game_p1(Nb, 1)) ->
		clearScreen,
		display_full_board(Nb, X, Y, 1),
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
	ask_play(B, L, C, Nl, Nc, Nb, J, S1, Ns1, S2, Ns2),
	clearScreen,
	display_full_board(Nb, X, Y, 1),
	J1 is J + 1,
	nl,
	((end_game_p2(Nb, 5); end_game_p1(Nb, 1)) ->
		clearScreen,
		display_full_board(Nb, X, Y, 1),
		nl,
		printGameOver,
		nl,
		nl,
		Fs1 is Ns1, Fs2 is Ns2;
		make_play(Nb, X, Y, Ns1, Ns2, Fs1, Fs2, J1)).

play(B, X, Y):-
	getChar(_),
	play_game(B, X, Y),
	make_play(B, X, Y, 0, 0, Fs1, Fs2, 1),
	compare_scores(Fs1, Fs2, 0),
	mainMenu.

play_vs_PC(B, X, Y):-
	Y = 'Computer',
	play_game(B, X, Y),
	make_play_vs_PC(B, X, Y, 0, 0, Fs1, Fs2, 1),
	compare_scores(Fs1, Fs2, 1),
	mainMenu.
