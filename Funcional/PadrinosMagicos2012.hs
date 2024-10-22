import Text.Show.Functions
data Chico = Chico {nombre :: String, edad :: Int, habilidades :: [String], deseos :: [Deseo]} deriving Show

type Deseo = Chico -> Chico

timmy = Chico "Timmy" 10 ["mirar television", "jugar en la pc"] [serMayor]
chester = Chico "Chester" 10 ["mirar television", "jugar en la pc","Saber cocinar"] [serMayor]

------------PARTE A------------

------------PUNTO 1------------
aprenderHabilidades :: String -> Deseo
aprenderHabilidades habilidad chico = chico {habilidades = habilidades chico ++ [habilidad]}

jugarNeedForSpeed :: Int -> Deseo
jugarNeedForSpeed version = aprenderHabilidades ("Jugar Need For Speed " ++ show version)

serGrosoEnNeedForSpeed :: [Int] -> Deseo
serGrosoEnNeedForSpeed versiones chico = undefined

serMayor :: Deseo
serMayor chico = chico {edad = 18}

------------PUNTO 2------------

madurar :: Chico -> Chico
madurar chico = chico {edad = edad chico + 1}

cumplirPrimerDeseo :: ([Deseo] -> Deseo)
cumplirPrimerDeseo = head

wanda :: [Deseo]
wanda = undefined

cosmo :: Deseo
cosmo chico = chico {edad = div (edad chico) 2}

muffinMagico :: [Deseo]
muffinMagico = undefined

------------PARTE B------------

------------PUNTO 1------------
tieneHabilidad :: String -> Chico -> Bool
tieneHabilidad habilidad chico = elem habilidad (habilidades chico)

esSuperMaduro :: Chico -> Bool
esSuperMaduro chico = edad chico > 18 && tieneHabilidad "Saber manejar" chico

------------PUNTO 2------------
data Chica = Chica {nombre' :: String, condicion :: Chico -> Bool}


trixie = Chica "Trixie" noEsTimmy
vicky = Chica "Vicky" (tieneHabilidad "Ser un supermodelo noruego")

noEsTimmy :: Chico -> Bool
noEsTimmy chico = nombre chico /= "Timmy"

cumpleCondicion :: Chica -> (Chico -> Bool)
cumpleCondicion = condicion

chicosConquistadores :: Chica -> [Chico] -> [Chico]
chicosConquistadores unaChica = filter (cumpleCondicion unaChica)

quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA unaChica losPretendientes | not (null (chicosConquistadores unaChica losPretendientes)) = head (chicosConquistadores unaChica losPretendientes)
                                          | otherwise = last losPretendientes

------------PUNTO 3------------

{-Consulta para una nueva chica:

quienConquistaA (Chica "Veronica" (tieneHabilidad "Saber cocinar") [timmy,chester]-}

------------PARTE C------------

infractoresDeDaRules :: [Chico] -> [String]
infractoresDeDaRules = map nombre