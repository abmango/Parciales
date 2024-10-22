import Text.Show.Functions
import Data.List

data Jugador = CJugador {nombre :: String, edad :: Int, promGol :: Int, habilidad :: Int, cansancio :: Int} deriving (Show, Eq)

data Equipo = Equipo {name :: String, grupo :: Char, jugadores :: [Jugador]} deriving Show

martin = CJugador "Martin" 26 0 50 35
juan = CJugador "Juancho" 30 0 50 40
maxi = CJugador "Maxi Lopez" 27 0 68 30

jonathan = CJugador "Chueco" 20 2 80 99
lean = CJugador "Hacha" 23 0 50 35
brian = CJugador "Panadero" 21 5 80 15

garcia = CJugador "Sargento" 30 1 80 13
messi = CJugador "Pulga" 26 10 99 43
aguero = CJugador "Aguero" 24 5 90 5

equipo1 = Equipo "Lo Que Vale Es El Intento" 'F' [martin, juan, maxi]
losDeSiempre = Equipo "Los De Siempre" 'F' [jonathan, lean, brian]
restoDelMundo = Equipo "Resto del Mundo" 'A' [garcia, messi, aguero]

---------------PUNTO 1---------------
{-Queremos saber los jugadores figura de cada equipo, los cuales tienen una habilidad mayor a 75 y promedio de gol mayor a 0.-}
esFigura :: Jugador -> Bool
esFigura jugador = promGol jugador > 0 && habilidad jugador > 75

jugadoresFigura :: Equipo -> [Jugador]
jugadoresFigura = filter esFigura . jugadores


---------------PUNTO 2---------------
{-Queremos averiguar si algún equipo tiene un jugador que sea de la farándula, dada una lista de jugadores faranduleros determinar si algún equipo tiene un jugador que pertenezca a la lista.-}
jugadoresFaranduleros = ["Maxi Lopez", "Icardi", "Aguero", "Caniggia", "Demichelis"]

esFarandulero :: Jugador -> Bool
esFarandulero jugador = nombre jugador `elem` jugadoresFaranduleros

hayFarandulero :: [Jugador] -> Bool
hayFarandulero [] = False
hayFarandulero (jugador:jugadores) | esFarandulero jugador = True
                                   | otherwise = hayFarandulero jugadores

tieneFarandulero :: Equipo -> Bool
tieneFarandulero = hayFarandulero . jugadores

---------------PUNTO 3---------------
{-Dados una serie de equipos y un grupo específico (A,B,C,D,E o F), le digamos los nombres de los jugadores que tendrían que ser las figuritas difíciles. Para cumplir la condición de ser difícil, el jugador 
tiene que ser figura, ser joven (menor a 27 años) y no ser de la farándula-}


esJoven :: Jugador -> Bool
esJoven jugador = edad jugador < 27

esFiguritaDificil :: Jugador -> Bool
esFiguritaDificil jugador = esFigura jugador && esJoven jugador && (not . esFarandulero) jugador

sonFiguritasDificiles :: Equipo -> [Jugador]
sonFiguritasDificiles equipo = filter esFiguritaDificil (jugadores equipo)

equiposConFiguritas :: [Equipo] -> [Jugador]
equiposConFiguritas = concatMap sonFiguritasDificiles


---------------PUNTO 4---------------
jugarPartido :: Jugador -> Jugador
jugarPartido jugador | esFiguritaDificil jugador = cansarFiguritaDificil jugador
                     | esJoven jugador = cansarJoven jugador
                     | esFigura jugador = cansarFigura jugador
                     | otherwise = duplicarCansancio jugador

cansarFiguritaDificil :: Jugador -> Jugador
cansarFiguritaDificil jugador = jugador {cansancio = 50}

cansarJoven :: Jugador -> Jugador
cansarJoven jugador = jugador {cansancio = cansancio jugador + div (cansancio jugador) 10}

cansarFigura :: Jugador -> Jugador
cansarFigura jugador = jugador {cansancio = cansancio jugador + 20}

duplicarCansancio :: Jugador -> Jugador
duplicarCansancio jugador = jugador {cansancio = cansancio jugador * 2}

---------------PUNTO 5---------------

sumarPromedioGol :: [Jugador] -> Int
sumarPromedioGol [jugador] = promGol jugador
sumarPromedioGol (jugador:jugadores) = promGol jugador + sumarPromedioGol jugadores

obtenerPromedioGol :: Equipo -> Int
obtenerPromedioGol = sumarPromedioGol . take 11 .jugadores

equipoJuega :: Equipo -> Equipo
equipoJuega equipo = equipo {jugadores = map jugarPartido (jugadores equipo)}

equipoGanador :: (Equipo, Equipo) -> Equipo
equipoGanador (equipo1,equipo2) | obtenerPromedioGol equipo1 > obtenerPromedioGol equipo2 = equipoJuega equipo1
                                | otherwise = equipoJuega equipo2
---------------PUNTO 6---------------

