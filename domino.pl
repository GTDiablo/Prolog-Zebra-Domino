% Boda Zsolt - EKKB9P
% Megoldás 1
% 1. Lombos - Otília - Mamikák
% 2. Zabos - Amalia - Nagyiklub
% 3. Gombos - Rozalia - Anyokak
% 4. Kabos - Emilia - Öregnenek
% 5. Dombos - Cecilia - Sztarklub

% Megoldás 2
% 1. Lombos - Otília - Nagyiklub
% 2. Zabos - Amalia - Mamikák
% 3. Gombos - Rozalia - Anyokak
% 4. Kabos - Emilia - Öregnenek
% 5. Dombos - Cecilia - Sztarklub


% emilia = M
% sztarklub = Y
% oregnene = X
% kabos = K
% lombos = L
% amalia = N
% rozalia = R
% nagyiklub = D
% anyokak = P
% gombos = A
% cecilia = B
% zabos = C
% dombos = E
% mamikak = O
% otilia = U

megold(T) :-
	% Gombos jobb helyezést ért el, mint Cecília és mint a Sztár-Klub versenyzője
  % de rosszabbat, mint Zabos -
  hely(A, T), vezetek(A, gombos), hely(B, T), kereszt(B, cecilia), hely(C, T),
  vezetek(C, zabos), valahol_elotte(B, A, T), valahol_elotte(Y, A, T),
  valahol_elotte(A, C, T),
  
  % Az Anyókák képviselője, közvetlenül Emília előtt végzett, aki közvetlenül
  % Dombos előtt végzett a bajnodkásogon,
  hely(P, T), klub(P, anyokak), kozvetlen_elotte(P, M, T), hely(E, T), vezetek(E, dombos),
  kozvetlen_elotte(M, E, T),

  % Rozália nem a Nagyi-Klub tagja -
  hely(R, T), kereszt(R, rozalia), hely(D, T), klub(D, nagyiklub), 

  % Lombos valahol Amália előtt, aki valahol az Öreg Nénék versenyzője előtt végzett. -
  hely(L, T), vezetek(L, lombos), hely(N, T), kereszt(N, amalia),
  valahol_elotte(N, L, T), valahol_elotte(X,N, T),

  % Kabos keresztneve nem Cecília és nem Rozália -
  hely(K, T), vezetek(K, kabos), 

  % Lombos keresztneve nem Emília -
  hely(M, T), kereszt(M, emilia), 

  % Gombos nem az Öreg Nénék képviselője -
  hely(X, T), klub(X, oregnenek), 
  
  % Emília nem a Sztár-klub tagja -
  hely(Y, T), klub(Y, sztarklub), 

  % Egyéb
  hely(O, T), klub(O, mamikak), 
  hely(U, T), kereszt(U, otilia),
  \+ K = B, \+ K = R,\+ M = L,\+ X = A,\+ M = Y,  \+ R = D, \+B = Y.
  

hely(X, helyek(X,_,_,_,_)).
hely(X, helyek(_,X,_,_,_)).
hely(X, helyek(_,_,X,_,_)).
hely(X, helyek(_,_,_,X,_)).
hely(X, helyek(_,_,_,_,X)).

valahol_elotte(X, Y, helyek(Y, _, _, _, X)).
valahol_elotte(X, Y, helyek(_, Y, _, _, X)).
valahol_elotte(X, Y, helyek(_, _, Y, _, X)).
%valahol_elotte(X, Y, helyek(_, _, _, Y, X)).
valahol_elotte(X, Y, helyek(Y, _, _, X, _)).
valahol_elotte(X, Y, helyek(_, Y, _, X, _)).
%valahol_elotte(X, Y, helyek(_, _, Y, X, _)).
valahol_elotte(X, Y, helyek(Y, _, X, _, _)).
%valahol_elotte(X, Y, helyek(_, Y, X, _, _)).
%valahol_elotte(X, Y, helyek(Y, X, _, _, _)).
valahol_elotte(X, Y, T) :- kozvetlen_elotte(Y, X, T).


kozvetlen_elotte(X,Y,helyek(X,Y,_,_,_)).
kozvetlen_elotte(X,Y,helyek(_,X,Y,_,_)).
kozvetlen_elotte(X,Y,helyek(_,_,X,Y,_)).
kozvetlen_elotte(X,Y,helyek(_,_,_,X,Y)).

vezetek(h(X,_,_),X).
kereszt(h(_, X, _),X).
klub(h(_,_,X),X).
