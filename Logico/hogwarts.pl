%%%%%%%%%%% Parte 1
%mago(Mago,Sangre)
mago(harry,mestizo).
mago(draco,puro).
mago(hermione,muggle).
mago(neville,muggle).

odiariaIr(harry,slytherin).
odiariaIr(draco,hufflepuff).

caracteristicas(harry,[corajudo,amistoso,orgulloso,inteligente]).
caracteristicas(draco,[inteligente,orgulloso]).
caracteristicas(hermione,[inteligente,orgulloso,responsable]).
caracteristicas(neville,[corajudo,amistoso]).

% Punto 1
esSangrePura(Sangre):-
    Sangre \= muggle.

permiteEntrar(Mago,slytherin):-
    mago(Mago,Sangre),
    esSangrePura(Sangre).

permiteEntrar(Mago, Casa):-
    mago(Mago,_),
    Casa\=slytherin.

% Punto 2
puedeIrA(Mago,gryffindor):-
    mago(Mago,_),
    caracteristicas(Mago,Caracteristicas),
    member(corajudo,Caracteristicas).

puedeIrA(Mago,slytherin):-
    mago(Mago,Sangre),
    caracteristicas(Mago,Caracteristicas),
    member(orgulloso,Caracteristicas),
    member(inteligente,Caracteristicas),
    esSangrePura(Sangre).

puedeIrA(Mago,ravenclaw):-
    mago(Mago,_),
    caracteristicas(Mago,Caracteristicas),
    member(responsable,Caracteristicas),
    member(inteligente,Caracteristicas).

puedeIrA(Mago,hufflepuff):-
    mago(Mago,_),
    esAmistoso(Mago).

esAmistoso(Mago):-
    caracteristicas(Mago,Caracteristicas),
    member(amistoso,Caracteristicas).

% Punto 3
enQueCasaQueda(Mago,Casa):-
    mago(Mago,Sangre),
    puedeIrA(Mago,Casa),
    permiteEntrar(Mago,Casa),
    not(odiariaIr(Mago,Casa)).

enQueCasaQueda(hermione,gryffindor).

% Punto 4

cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago,Magos), esAmistoso(Mago)).

cadenaDeCasas([Mago1,Mago2] | OtrosMagos):-
    puedeIrA(Mago1,Casa),
    puedeIrA(Mago2,Casa),
    cadenaDeCasas([Mago2 | OtrosMagos]).

cadenaDeCasas([_]).

cadenaDeCasas([]).
%%%%%%%%%%% Parte 2

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

accion(harry,resta(fueraDeCama)).
accion(harry,resta(irAlTercerPiso)).
accion(harry,resta(irAlBosque)).
accion(harry,suma(ganarleAVoldy)).
accion(ron,suma(ganarEnAjedrez)).
accion(hermione,resta(irAlTercerPiso)).
accion(hermione,resta(irABibliotecaRestringida)).
accion(draco,resta(irAMazmorras)).

% Punto 1
esBuenAlumno(Mago,Accion):-
    esDe(Mago,_),
    accion(Mago,suma(_)).

% Punto 2
accionRecurrente(Accion):-
    accion(Mago,Accion),
    accion(OtroMago,Accion),
    Mago \= OtroMago.

% Punto 3
/*ganadorDeLaCopa(Casa):-
    esDe(Mago,Casa),
    puntosTotales(Casa).*/

%puntosTotales(Casa):-
