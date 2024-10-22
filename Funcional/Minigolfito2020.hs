{-Lisa Simpson se propuso desarrollar un programa que le permita ayudar a su hermano a vencer a su vecino Todd en un torneo de minigolf. Para hacerlo más interesante, los padres de los niños hicieron una
apuesta: el padre del niño que no gane deberá cortar el césped del otro usando un vestido de su esposa.

De los participantes nos interesará el nombre del jugador, el de su padre y sus habilidades (fuerza y precisión).
-}
import Text.Show.Functions

data Jugador = UnJugador {nombre :: String, padre :: String, habilidad :: Habilidad} deriving (Eq, Show)
data Habilidad = Habilidad {fuerzaJugador :: Int, precisionJugador :: Int} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {velocidad :: Int, precision :: Int, altura :: Int} deriving (Eq, Show)

tiroDetenido = UnTiro 0 0 0

type Puntos = Int

-- Funciones útiles
between n m x = x `elem` [n .. m]

maximoSegun f = foldl1 (mayorSegun f)

mayorSegun f a b
  | f a > f b = a
  | otherwise = b

---punto 1---

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro 10 (precisionJugador habilidad * 2) 0

madera :: Palo
madera habilidad = UnTiro 100 (precisionJugador habilidad `div` 2 ) 0

hierros :: Int -> Palo
hierros n habilidad = UnTiro (fuerzaJugador habilidad * n) (precisionJugador habilidad `div` n) (max 0 (n - 3))

palos :: [Palo]
palos = [putter,madera] ++ map hierros [1..10]

---punto 2---

golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = (palo . habilidad) jugador

---punto 3---

tunel :: Tiro -> Tiro
tunel = superaObstaculo superaTunel efectoTunel

vaAlRasDelSuelo :: Tiro -> Bool
vaAlRasDelSuelo = (==0) . altura

efectoTunel :: Tiro -> Tiro
efectoTunel tiro = tiro {velocidad = velocidad tiro * 2, precision = 100, altura = 0}

superaTunel :: Tiro -> Bool
superaTunel tiro = precision tiro > 90 && vaAlRasDelSuelo tiro

laguna :: Int -> Tiro -> Tiro
laguna largo = superaObstaculo superaLaguna (efectoLaguna largo)

efectoLaguna :: Int -> Tiro -> Tiro
efectoLaguna largo tiro = tiro {altura = div (altura tiro) largo}

superaLaguna :: Tiro -> Bool
superaLaguna tiro = velocidad tiro > 80 && (between 1 5 . altura) tiro

superaObstaculo :: (Tiro -> Bool) -> (Tiro -> Tiro) -> Tiro -> Tiro
superaObstaculo criterio efecto tiro | criterio tiro = efecto tiro
                                     | otherwise = tiroDetenido

hoyo :: Tiro -> Tiro
hoyo  = superaObstaculo superaHoyo efectoHoyo

superaHoyo :: Tiro -> Bool
superaHoyo tiro = (between 5 20 . velocidad) tiro && (precision tiro > 95) && vaAlRasDelSuelo tiro

efectoHoyo :: Tiro -> Tiro
efectoHoyo _ = tiroDetenido

---punto 4---

palosUtiles :: Habilidad -> (Tiro -> Tiro) -> Palo
palosUtiles habilidad f = undefined