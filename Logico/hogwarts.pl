mago(harry,mestizo,odia(slytherin)).
mago(draco,puro,odia(hufflepuff)).
mago(hermione,muggle,_).

caracteristicas(harry,[corajudo,amistoso,orgulloso,inteligente]).
caracteristicas(draco,[inteligente,orgulloso]).
caracteristicas(hermione,[inteligente,orgulloso,responsable]).

esSangrePura(Sangre):-
    Sangre \= muggle.

puedeIrA(Mago,gryffindor):-
    mago(Mago,_,Casa),
    caracteristicas(Mago,Caracteristicas),
    member(corajudo,Caracteristicas).

puedeIrA(Mago,slytherin):-
    mago(Mago,Sangre,Casa),
    caracteristicas(Mago,Caracteristicas),
    member(orgulloso,Caracteristicas),
    member(inteligente,Caracteristicas),
    esSangrePura(Sangre).

puedeIrA(Mago,ravenclaw):-
    mago(Mago,_,Casa),
    caracteristicas(Mago,Caracteristicas),
    member(responsable,Caracteristicas),
    member(inteligente,Caracteristicas).

puedeIrA(Mago,hufflepuff):-
    mago(Mago,_,Casa),
    caracteristicas(Mago,Caracteristicas),
    member(amistoso,Caracteristicas).

permiteEntrar(Mago,slytherin):-
    not(esSangreSucia(Mago)).