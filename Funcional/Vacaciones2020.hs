import Text.Show.Functions

data Turista = Turista {cansancio :: Int, stress :: Int, viajaSolo :: Bool, idiomas :: [Idioma]} deriving Show

type Idioma = String

type Excursion = Turista -> Turista

ana = Turista 0 21 False ["Espanol"]
beto = Turista 15 15 True ["Espanol", "Catalan"]
cathi = Turista 15 15 True ["Espanol", "Catalan"]

cambiarStress delta turista = turista {stress = stress turista + delta}

cambiarStressPorcentual porciento turista = cambiarStress (div (porciento * stress turista) 100) turista

cambiarCansancio delta turista = turista {cansancio = cansancio turista + delta}

aprenderIdioma idioma turista = turista {idiomas = idioma : idiomas turista}

acompaniado turista = turista {viajaSolo = False}

data Marea = Tranquila | Moderada | Fuerte

deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2


apreciar :: String -> Excursion
apreciar algo = cambiarStress (-length algo)

salirConGente :: Idioma -> Excursion
salirConGente idioma = acompaniado . aprenderIdioma idioma

caminar :: Int -> Excursion
caminar mins = cambiarStress (-intensidad mins) . cambiarCansancio (intensidad mins)

intensidad mins = div mins 4

paseoEnBarco :: Marea -> Excursion
paseoEnBarco Tranquila = acompaniado
paseoEnBarco Moderada  = id
paseoEnBarco Fuerte    = cambiarCansancio 10 . cambiarStress 6

hacerExcursion :: Excursion -> Turista -> Turista
hacerExcursion excursion = cambiarStressPorcentual (-10) . excursion

