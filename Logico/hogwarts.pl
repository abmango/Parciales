%%%%%%%%%%% Parte 1
%mago(Mago,Sangre,CasaQueOdia)
mago(harry,mestizo,odia(slytherin)).
mago(draco,puro,odia(hufflepuff)).
mago(hermione,muggle,_).

caracteristicas(harry,[corajudo,amistoso,orgulloso,inteligente]).
caracteristicas(draco,[inteligente,orgulloso]).
caracteristicas(hermione,[inteligente,orgulloso,responsable]).

esSangrePura(Sangre):-
    Sangre \= muggle.

% Punto 1
permiteEntrar(Mago,slytherin):-
    mago(Mago,Sangre,_),
    esSangrePura(Sangre).

permiteEntrar(Mago, Casa):-
    mago(Mago,_,_),
    Casa \= slytherin.

% Punto 2
puedeIrA(Mago,gryffindor):-
    mago(Mago,_,_),
    caracteristicas(Mago,Caracteristicas),
    member(corajudo,Caracteristicas).

puedeIrA(Mago,slytherin):-
    mago(Mago,Sangre,_),
    caracteristicas(Mago,Caracteristicas),
    member(orgulloso,Caracteristicas),
    member(inteligente,Caracteristicas),
    esSangrePura(Sangre).

puedeIrA(Mago,ravenclaw):-
    mago(Mago,_,_),
    caracteristicas(Mago,Caracteristicas),
    member(responsable,Caracteristicas),
    member(inteligente,Caracteristicas).

puedeIrA(Mago,hufflepuff):-
    mago(Mago,_,_),
    esAmistoso(Mago,Caracteristicas).

esAmistoso(Mago,Caracteristicas):-
    caracteristicas(Mago,Caracteristicas),
    member(amistoso,Caracteristicas).

% Punto 3
enQueCasaQueda(Mago,Casa):-
    mago(Mago,Sangre,CasaQueOdia),
    puedeIrA(Mago,Casa),
    permiteEntrar(Mago,Casa),
    CasaQueOdia\=Casa.

% Punto 4
cadenaDeAmistades(Magos):-
    findall(Mago,esAmistoso(Mago,Caracteristicas),Magos).

