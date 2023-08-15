%composicion(plato, [ingrediente])%
composicion(platoPrincipal(milanesa),[ingrediente(pan,3),ingrediente(huevo,2),ingrediente(carne,2)]).
composicion(entrada(ensMixta),[ingrediente(tomate,2),ingrediente(cebolla,1),ingrediente(lechuga,2)]).
composicion(entrada(ensFresca),[ingrediente(huevo,1),ingrediente(remolacha,2),ingrediente(zanahoria,1)]).
composicion(postre(budinDePan),[ingrediente(pan,2),ingrediente(caramelo,1)]).

%calorías(nombreIngrediente, cantidadCalorias)%
calorias(pan,30).
calorias(huevo,18).
calorias(carne,40).
calorias(caramelo,170).

%proveedor(nombreProveedor, [nombreIngredientes])%
proveedor(disco, [pan, caramelo, carne, cebolla]).
proveedor(sanIgnacio, [zanahoria, lechuga, miel, huevo]).

%Punto 1:
caloriasTotal(Plato, CaloriasTotales):- %Se podría agregar algo como nombrePlato para que te genere sólo el nombre y no todo el functor.
    composicion(Plato,Ingredientes),
    findall(CaloriasIngrediente, caloriasPorIngrediente(Ingredientes, CaloriasIngrediente), Calorias),
    sum_list(Calorias, CaloriasTotales).

caloriasPorIngrediente(Ingredientes, CaloriasIngrediente):-
    member(Ingrediente, Ingredientes),
    caloriaIngrediente(Ingrediente,CaloriasIngrediente).

caloriaIngrediente(ingrediente(Ingrediente,Cantidad), Calorias):-
    calorias(Ingrediente, CaloriasIngrediente),
    Calorias is CaloriasIngrediente * Cantidad.

%Punto 2/3:
platoSimpatico(Plato):-
    tieneIngredienteUnPlato(huevo, Plato),
    tieneIngredienteUnPlato(pan, Plato).
platoSimpatico(Plato):-
    caloriasTotal(Plato,CaloriasTotales),
    CaloriasTotales < 200.

tieneIngrediente(Ingredientes, Ingrediente):-
    member(ingrediente(Ingrediente,_), Ingredientes).

%Punto 4:
menuDiet(PrimerPlato, SegundoPlato, TercerPlato):-
    tipoDePlatoYCalorias(PrimerPlato, entrada, CaloriasPrimerPlato),
    tipoDePlatoYCalorias(SegundoPlato, platoPrincipal, CaloriasSegundoPlato),
    tipoDePlatoYCalorias(TercerPlato, postre, CaloriasTercerPlato),
    CaloriasPrimerPlato + CaloriasSegundoPlato + CaloriasTercerPlato < 450.

tipoDePlato(platoPrincipal(_), platoPrincipal).
tipoDePlato(entrada(_), entrada).
tipoDePlato(postre(_), postre).

tipoDePlatoYCalorias(Plato, Tipo, Calorias):-
    composicion(Plato, _),
    caloriasTotal(Plato, Calorias),
    tipoDePlato(Plato, Tipo).
    

%Punto 5:
tieneTodo(Proveedor, Plato):-
    composicion(Plato, Ingredientes),
    proveedor(Proveedor,IngredientesP),
    forall(tieneIngrediente(Ingredientes, Ingrediente), member(Ingrediente, IngredientesP)). %Se podría hacer directo así o delegando.

loProvee(Proveedor, Ingrediente):-
    proveedor(Proveedor, IngredientesQueProvee),
    member(Ingrediente, IngredientesQueProvee).

%Punto 6:
ingredientePopular(Ingrediente):-
    tieneIngredienteUnPlato(Ingrediente, UnPlato),
    tieneIngredienteUnPlato(Ingrediente, OtroPlato),
    tieneIngredienteUnPlato(Ingrediente, PlatoDistinto),
    UnPlato \= OtroPlato,
    OtroPlato \= PlatoDistinto,
    UnPlato \= PlatoDistinto.

tieneIngredienteUnPlato(Ingrediente, Plato):-
    composicion(Plato, Ingredientes),
    tieneIngrediente(Ingredientes, Ingrediente).

%Punto 7:
    