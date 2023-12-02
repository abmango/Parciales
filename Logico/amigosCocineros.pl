%cocina(Nombre,Plato,Puntos)
cocina(mariano, principal(nioquis,50), 80).
cocina(julia, principal(pizza,100), 60).
cocina(hernan, postre(panqueque, dulceDeLeche,100), 60).
cocina(hernan, postre(trufas, dulceDeLeche,60), 80).
cocina(hernan, entrada(ensalada, [tomate, zanahoria, lechuga], 70), 29).
cocina(susana, entrada(empanada, [carne, cebolla, papa], 50), 50).
cocina(susana, postre(pastelito, dulceDeMembrillo,50), 60).
cocina(melina, postre(torta, zanahoria, 60), 50).

%completar base de conocimiento y justificar aquellos que no se agregan

%amigo(Cocinero,OtroCocinero)
amigo(mariano, susana).
amigo(mariano, hernan).
amigo(hernan, pedro).
amigo(melina, carlos).
amigo(carlos, susana).
%amigo(susana,_). Este no se agrega ya que, por principio de universo cerrado, no es necesario agregar aquellos que no tienen amigos.

%popular(Ingrediente)
popular(carne).
popular(dulceDeLeche).
popular(dulceDeMembrillo).
%La cebolla y la zanahoria no son populares, por lo tanto, aplicando el principio de universo cerrado no es necesario agregar estos dos elementos.

% Punto 1: saber si un plato es saludable

esSaludable(Plato):-
    cocina(_,Plato,_),
    cumpleCondiciones(Plato).

cumpleCondiciones(postre(_,_,Cantidad)):-
    Cantidad < 100.

cumpleCondiciones(entrada(_,_,Cantidad)):-
    Cantidad < 60.

cumpleCondiciones(principal(_,Cantidad)):-
    between(70, 90, Cantidad).

% Punto 2:saber si un cocinero no cocina postres
esCocinero(Cocinero):-
    cocina(Cocinero,_,_).

soloSalado(Cocinero):-
    esCocinero(Cocinero),
    not((cocina(Cocinero,Plato,_),
    esPostre(Plato))).

esPostre(postre(_,_,_)).

% Punto 3: saber si un cocinero tiene el máximo nivel de puntuación
sumatoriaDePuntos(Cocinero,Puntaje):-
    findall(Puntos, cocina(Cocinero,_,Puntos),ListaPuntos),
    sumlist(ListaPuntos,Puntaje).

% Punto 4: saber si un cocinero no es saludable (que tenga sólo 1 plato saludable y que todos los demás no lo sean)
noEsSaludable(Cocinero):-
    cocina(Cocinero,Plato,_),
    esSaludable(Plato),
    not((cocina(Cocinero,OtroPlato,_), esSaludable(Plato), Plato\=OtroPlato)).

% Punto 5: saber si un cocinero no usa nunca ingredientes populares
noUsaIngredientesPopulares(Cocinero):-
    forall(cocina(Cocinero,Plato,_), not(tieneIngredientesPopulares(Plato))).

tieneIngredientesPopulares(postre(_,Ingrediente,_)):-
    popular(Ingrediente).

tieneIngredientesPopulares(entrada(_,Ingredientes,_)):-
    findall(Ingrediente, popular(Ingrediente), Ingredientes).

% Punto 7: saber si un cocinero puede ser recomendado por otro
esRecomendadoPorColega(Cocinero,OtroCocinero):-
    not(noEsSaludable(Cocinero)),
    esRecomendable(Cocinero,OtroCocinero).

esRecomendable(Cocinero,OtroCocinero):-
    amigo(Cocinero,OtroCocinero).

esRecomendable(Cocinero,OtroCocinero):-
    not(amigo(Cocinero,OtroCocinero)),
    amigo(OtroCocinero,_).