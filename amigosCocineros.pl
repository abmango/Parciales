%cocina(Nombre,Plato,Puntos)
cocina(mariano, principal(ñoquis,50), 80).
cocina(julia, principal(pizza,100), 60).
cocina(hernan, postre(panqueque, dulceDeLeche,100), 60).
cocina(hernan, postre(trufas, dulceDeLeche,60), 80).
cocina(hernan, entrada(ensalada, [tomate, zanahoria, lechuga], 70), 29).
cocina(susana, entrada(empanada, [carne, cebolla, papa], 50), 50).
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
soloSalado(Cocinero):-
    cocina(Cocinero,Plato,_),
    not(esPostre(Plato)).

esPostre(postre(_,_,_)).

% Punto 3:
sumatoriaPuntos(Cocinero,Puntaje):-
    cocina(Cocinero,Plato,Cantidad),
    cocina(Cocinero,OtroPlato,OtraCantidad),
    Puntaje is Cantidad + OtraCantidad.

tieneUnaGranFama(Cocinero):-
    findall(Cocinero, sumatoriaPuntos(Cocinero,Puntaje), ListaCocinero),
    max_member(Cocinero,ListaCocinero).

% Punto 4: saber si un cocinero no es saludable (que tenga sólo 1 plato saludable y que todos los demás no lo sean)
noEsSaludable(Cocinero):-
    cocina(Cocinero,Plato,_),
    esSaludable(Plato),
    not((cocina(Cocinero,OtroPlato,_), esSaludable(Plato), Plato\=OtroPlato)).

% Punto 5: saber si un cocinero no usa nunca ingredientes populares
noUsaIngredientesPopulares(Cocinero):-
    cocina(Cocinero,Plato,_),
    not(tieneIngredientesPopulares(Plato)).

tieneIngredientesPopulares(postre(_,Ingrediente,_)):-
    popular(Ingrediente).

tieneIngredientesPopulares(entrada(_,Ingredientes,_)):-
    findall(Ingrediente, popular(Ingrediente), Ingredientes).