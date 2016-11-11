:- use_module(library(lists)).

% Return element by index (Row,col)

  getelem(B,L,C,Elem):-

  nth1(L,B,MatrixRow),
  nth1(C, MatrixRow, Elem).
  %write(Elem).

% Checks the path of the movement

	check_path_col(B, Nl, C, Nc, Inc):-
		(C = Nc -> write('path_col valido\n'), true;
		Next is C + Inc,
		getelem(B, Nl, Next, Elem),
		(Elem \= 's' -> write('path col invalido\n'), false; check_path_col(B, Nl, Next, Nc, Inc))).

	check_path_line(B, L, Nl, Nc, Inc):-
		(L = Nl -> write('path_line valido\n'), true;
		Next is L + Inc,
		getelem(B, Next, Nc, Elem),
		(Elem \= 's' -> write('path line invalido\n'), false; check_path_line(B, Next, Nl, Nc, Inc))).

	check_path_line_col(B, L, C, Nl, Nc, IncL, IncC):-
		(L = Nl, C = Nc -> write('path_line_col valido\n'), true;
		NextL is L + IncL,
		NextC is C + IncC,
		getelem(B, NextL, NextC, Elem),
		(Elem \= 's' -> write('path invalido\n'), false; check_path_line_col(B, NextL, NextC, Nl, Nc, IncL, IncC))).

% Convert letter to an index

letterToNumber(Letra,Numero):-
  (Letra == 'a' -> Numero is 1;
  Letra == 'b' -> Numero is 2;
  Letra == 'c' -> Numero is 3;
  Letra == 'd' -> Numero is 4).
%_______________________________________________________________

% Verifica se Input esta entre A-D
letra(X,_,_) :- X = 'a'; X = 'b'; X = 'c'; X = 'd'.
letra(_,X,L1) :- write('Letra invalida! Try Again\n'), nl.

% Verifica se Input esta entre 1-8
numero(X,_,_) :- integer(X), X >= 1,  X =< 8.
numero(_,X,L1) :- write('Valor invalido! Try Again\n'), nl.

%____________________________________________________________________
getNewLine :-
        get_code(T) , (T == 10 -> ! ; getNewLine).

getDigit(D) :-
        get_code(Dt) , D is Dt - 48 , (Dt == 10 -> ! ; getNewLine).

getChar(C) :-
        get_char(C) , char_code(C, Co) , (Co == 10 -> ! ; getNewLine).

%____________________________________________________________________


%
% replace a single cell in a list-of-lists
% - the source list-of-lists is L
% - The cell to be replaced is indicated with a row offset (X)
%   and a column offset within the row (Y)
% - The replacement value is Z
% - the transformed list-of-lists (result) is R
%
replace( L , X , Y , Z , R ) :-
  append(RowPfx,[Row|RowSfx],L),     % decompose the list-of-lists into a prefix, a list and a suffix
  length(RowPfx,X) ,                 % check the prefix length: do we have the desired list?
  append(ColPfx,[_|ColSfx],Row) ,    % decompose that row into a prefix, a column and a suffix
  length(ColPfx,Y) ,                 % check the prefix length: do we have the desired column?
  append(ColPfx,[Z|ColSfx],RowNew) , % if so, replace the column with its new value
  append(RowPfx,[RowNew|RowSfx],R) .  % and assemble the transformed list-of-lists
  					%


pawn_can_move(B,L,C,Nl,Nc):-
	DL is abs(Nl-L),
	DC is abs(Nc-C),
	(DC=1,DL=1 -> nl ; (write('Jogada invalida\n') ,false)),
	getelem(B,Nl,Nc,Elem),
	(Elem='s' -> write('Jogada valida\n'),nl,nl,true; write('Jogada invalida\n'),false ).

drone_can_move(B,L,C,Nl,Nc):-
	AbsDL is abs(Nl-L),
	AbsDC is abs(Nc-C),
	DL is Nl-L,
	DC is Nc-C,

	(AbsDC=0,AbsDL=0 ->  (write('Jogada invalida\n') ,false );
	((AbsDL=1 ;AbsDL=2),AbsDC=0 );((AbsDC=1;AbsDC=2),AbsDL=0) -> nl;  write('Jogada invalida\n'),false),

	(
		DL = 0, DC < 0 -> check_path_col(B, Nl, C, Nc, -1);
		DL = 0, DC > 0 -> check_path_col(B, Nl, C, Nc, 1);

		DC = 0, DL < 0 -> check_path_line(B, L, Nl, Nc, -1);
		DC = 0, DL > 0 -> check_path_line(B, L, Nl, Nc, 1);
		nl
	).

queen_can_move(B, L, C, Nl, Nc):-
	DL is Nl-L,
	DC is Nc-C,
	(
		DC=0,DL=0 -> write('Jogada invalida\n') , false;

		DL = 0, DC < 0 -> check_path_col(B, Nl, C, Nc, -1);
		DL = 0, DC > 0 -> check_path_col(B, Nl, C, Nc, 1);

		DC = 0, DL < 0 -> check_path_line(B, L, Nl, Nc, -1);
		DC = 0, DL > 0 -> check_path_line(B, L, Nl, Nc, 1);
		nl
	),

	AbsL is abs(DL),
	AbsC is abs(DC),

	(AbsL \= AbsC -> write('Jogada invalida abs\n'), false; nl),

	(
		DL < 0, DC < 0 -> check_path_line_col(B, L, C, Nl, Nc, -1, -1);
		DL < 0, DC > 0 -> check_path_line_col(B, L, C, Nl, Nc, -1, 1);
		DL > 0, DC < 0 -> check_path_line_col(B, L, C, Nl, Nc, 1, -1);
		DL > 0, DC > 0 -> check_path_line_col(B, L, C, Nl, Nc, 1, 1);
		nl
		).


end_game_p1(B, C):-
	(
		C = 5 -> true;
		nth1(C, B, Elem),
		(
			Elem = ['s', 's', 's', 's'] -> false
		),

	C1 is C + 1,
	end_game_p1(B, C1)).

end_game_p2(B, C):-
	(
		C = 9 -> true;
		nth1(C, B, Elem),
		(
			Elem = ['s', 's', 's', 's'] -> false
		),

	C1 is C + 1,
	end_game_p2(B, C1)).



move_piece(B,L,C,Nl,Nc,Nr):-
	getelem(B,L,C,Elem),
	write(Elem),
	(
		Elem = 's' -> write('peça invalida\n'), ask_play(B,L1, C1, Nl1, Nc1,Nr);
		Elem = 'p' -> F is 0;
		Elem = 'd' -> F is 1;
		Elem = 'q' -> F is 2
	),

		Li is L - 1,
		Ci is C - 1,

		NLi is Nl - 1,
		NCi is Nc - 1,

	(
		F = 0, pawn_can_move(B, L, C, Nl, Nc) -> replace(B, Li, Ci, 's', N), replace(N,NLi, NCi,Elem, Nr);
		F = 1, drone_can_move(B, L, C, Nl, Nc) -> replace(B, Li, Ci, 's', N), replace(N,NLi, NCi,Elem, Nr);
		F = 2, queen_can_move(B, L, C, Nl, Nc) -> replace(B, Li, Ci, 's', N), replace(N,NLi, NCi,Elem, Nr)
	).
