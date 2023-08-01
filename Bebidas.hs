--Punto a: Modelamos a la persona y los tipos
data Persona = Persona {nombre :: String, habilidades :: Habilidades, reflejos :: Int, bebidas :: [Bebida]}

type Habilidades = [String]

type Bebida = Persona -> Persona

--Punto b: modelar bebidas
cafe :: Bebida
cafe = cambiarReflejos 5

cambiarReflejos :: Int -> Persona -> Persona
cambiarReflejos cantidad persona = persona {reflejos = cantidad + reflejos persona}

whisky :: Bebida
whisky persona = persona {habilidades = filter reduceHabilidad (habilidades persona)}

reduceHabilidad :: String -> Bool
reduceHabilidad habilidad = length habilidad <= 6

cerveza :: Int -> Bebida
cerveza porcentaje persona = cambiarReflejos (-porcentaje) (persona {habilidades = tail (habilidades persona)})

gaseosa :: Int -> Bebida
gaseosa azucar = cambiarReflejos (div azucar 2)

aguaMineral :: Bebida
aguaMineral persona = persona

teDeTilo = (\persona -> cambiarReflejos (-20) persona)

--Punto c: modelar a Ana según lo que pide el enunciado
ana = Persona "Ana" ["jugar al poker", "cantar"] 20 [cerveza 3, gaseosa 5]

--Punto d: definir tomar que dado una persona y una bebida agrega la bebida a la lista correspondiente y aplica los efectos
tomar :: Persona -> Bebida -> Persona
tomar persona bebida = bebida (persona {bebidas = bebidas persona ++ [bebida]})

--Punto e: definir degustar que dado una persona y un trago (conjunto de bebidas) devuelve a la persona con esos efectos.
degustar :: Persona -> [Bebida] -> Persona
degustar = foldl tomar

--Punto f: dado un conjunto de personas y un trago, concer quiénes están sobrios luego de tomar el trago según los criterios.
personasSobrias :: [Bebida] -> [Persona] -> [Persona]
personasSobrias bebidas = filter (estaSobrio bebidas)

estaSobrio :: [Bebida] -> Persona -> Bool
estaSobrio bebidas persona = (length (habilidades persona) > 2) && (reflejos persona > 80)

--Punto g: dada una persona y un trago, conocer la mejor bebida que es aquella que la deja con mayor reflejo (no usar recursividad)
--Este todavía no lo pude sacar del todo así que lo dejo para que alguno más lo resuelva.
laMejorBebida :: Persona -> [Bebida] -> Bebida
laMejorBebida persona bebidas = undefined

--Punto h: construir un trago infinito y construir una persona con infinitas habilidades
tragoInfinito :: Bebida -> [Bebida]
tragoInfinito = repeat

pepe = Persona "Pepe" (map repeat "Saber manejar") 20 [aguaMineral]

--Punto i: dada la persona y el trago infinito construido en el punto anterior, se busca saber si hay una consulta que
--nos diga si hay una bebida que deje sobria a la persona. Justificar conceptualmente y dar ejemplo de invocación y respuesta

{-ghci> laMejorBebida pepe (tragoInfinito cafe)

-}