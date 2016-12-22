%%%%%%%%%%%ClearScreen%%%%%%%%%%%%%%%%%%
clearScreen :-
		printBlank(65).

printBlank(A) :-
			A > 0,
			nl,
			A1 is A - 1,
			printBlank(A1).

printBlank(_).


printMainMenu:-
  write('###########################################################'),nl,
	write('################# Crazy Pavement Puzzle ###################'),nl,
	write('###########################################################'),nl,
  nl, nl,
  write('1- See puzzle 1 (7x7)'), nl,
  write('2- See puzzle 2 (10x10)'), nl,
  write('3- See puzzle 3 (7x6)'), nl,
  write('4- Exit'), nl,
  printBlank(20).


printPuzzle1Menu:-
  write('###########################################################'),nl,
  write('######################## Puzzle 1 #########################'),nl,
  write('###########################################################'),nl, nl.

printPuzzle2Menu:-
  write('###########################################################'),nl,
  write('######################## Puzzle 2 #########################'),nl,
  write('###########################################################'),nl, nl.


printPuzzle3Menu:-
  write('###########################################################'),nl,
  write('######################## Puzzle 3 #########################'),nl,
  write('###########################################################'),nl, nl.
  
printPuzzle1Result:-
  write('###########################################################'),nl,
  write('######################## Puzzle 1 #########################'),nl,
  write('###########################################################'),nl,
  write('######################### Result ##########################'),nl, nl.

printPuzzle2Result:-
  write('###########################################################'),nl,
  write('######################## Puzzle 2 #########################'),nl,
  write('###########################################################'),nl,
  write('######################### Result ##########################'),nl, nl.
  
  printPuzzle3Result:-
  write('###########################################################'),nl,
  write('######################## Puzzle 3 #########################'),nl,
  write('###########################################################'),nl,
  write('######################### Result ##########################'),nl, nl.



mainMenu:-
  clearScreen,
  printMainMenu,
  get_char(In),
  showPuzzleMenu(In).

showPuzzleMenu(In):-
  In = '1',
  clearScreen,
  printPuzzle1Menu,
  board_area1(B1),
  display_area_board1(B1),
  get_char(_),
  write('Press any key to show the result of the puzzle...'),
  printBlank(20),
  get_char(_),
  solvePuzzle1Menu.

showPuzzleMenu(In):-
  In = '2',
  clearScreen,
  printPuzzle2Menu,
  board_area2(B2),
  display_area_board2(B2),
  get_char(_),
  write('Press any key to show the result of the puzzle...'),
  printBlank(20),
  get_char(_),
  solvePuzzle2Menu.
  
 showPuzzleMenu(In):-
  In = '3',
  clearScreen,
  printPuzzle3Menu,
  board_area1(B1),
  display_area_board1(B1),
  get_char(_),
  write('Press any key to show the result of the puzzle...'),
  printBlank(20),
  get_char(_),
  solvePuzzle1Menu.

showPuzzleMenu(In):- In = '4'.

solvePuzzle1Menu:-
  clearScreen,
  printPuzzle1Result, nl,
  solve_puzzle1,
  nl,
  write('Press any key to go back...'),
  printBlank(20),
  get_char(_),
  mainMenu.

solvePuzzle2Menu:-
  clearScreen,
  printPuzzle2Result, nl,
  solve_puzzle2,
  nl,
  write('Press any key to go back...'),
  printBlank(20),
  get_char(_),
  mainMenu.
  
  solvePuzzle3Menu:-
  clearScreen,
  printPuzzle3Result, nl,
  solve_puzzle3,
  nl,
  write('Press any key to go back...'),
  printBlank(20),
  get_char(_),
  mainMenu.
