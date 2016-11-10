:- use_module(library(lists)).

% Return element by index (Row,col)
	
  getelem(B,L,C,Elem):-

  nth1(L,B,MatrixRow),
  nth1(C, MatrixRow, Elem),
  write(Elem).

% Convert letter to an index

letterToNumber(Letra,Numero):-
  (Letra == 'a' -> Numero is 1;
  Letra == 'b' -> Numero is 2;
  Letra == 'c' -> Numero is 3;
  Letra == 'd' -> Numero is 4).
%_______________________________________________________________

% Verifica se Input esta entre A-D
letra(X,_,_) :- X = 'a'; X = 'b'; X = 'c'; X = 'd'.
letra(_,X,L1) :- write('Letra invalida! Try Again'), nl, jogada(X,L1).

% Verifica se Input esta entre 1-8
numero(X,_,_) :- integer(X), X >= 1,  X =< 8.
numero(_,X,L1) :- write('Valor invalido! Try Again'), nl, jogada(X,L1).

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
	(DC=1,DL=1 -> nl ; (write('Jogada invalida') ,false)),
	getelem(B,Nl,Nc,Elem),
	(Elem='s' -> write('Jogada valida'),true; write('Jogada invalida'),false ).

drone_can_move(B,L,C,Nl,Nc):-
	DL is abs(Nl-L),
	DC is abs(Nc-C),
	(DC=0,DL=0 ->  (write('Jogada invalida') ,false ); 

	((DL=1 ;DL=2),DC=0 );((DC=1;DC=2),DL=0)-> nl;  write('Jogada invalida'),false),
	(DL=2-> P=Nl-1,getelem(B,P,Nc,Elem);  ),
	(Elem='s'-> F is 1 ; F is 0 ),
	(DC=2-> P=Nc-1,getelem(B,Nl,P,Elem); ),
	(Elem='s'-> F is 1 ; F is 0 ),
	getelem(B,Nl,Nc,Elem),
	(Elem='s', F=1 -> (write('Jogada valida'),true); write('Jogada invalida'),false ).
	

	
/**	
move_piece(B,L,C,Nl,Nc,Elem,Nb):-
	getelem(B,L,C,Elem),
	write(Elem),
	% condiçoes de movimento
	%replace
*/