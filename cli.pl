:- include('board.pl').

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
		play_game(B, X, Y).


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




