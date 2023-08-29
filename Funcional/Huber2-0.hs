import Text.Show.Functions

data Chofer = Chofer {nombre :: String, kilometraje :: Int, viajes :: [Viaje], condicion :: Condicion} deriving Show

type Condicion = Viaje -> Bool

data Viaje = Viaje {fecha :: (Int, Int, Int), cliente :: Cliente, costo :: Int} deriving Show

data Cliente = Cliente {nombre' :: String, direccion :: String} deriving Show

cualquierViaje :: Condicion
cualquierViaje _ = True

viajeSegunCosto :: Condicion
viajeSegunCosto = (>200) . costo

viajeSegunNombre :: Int -> Condicion
viajeSegunNombre tamanio viaje = length (nombre' (cliente viaje)) > tamanio

viajeSegunZona :: String -> Condicion
viajeSegunZona zona viaje = direccion (cliente viaje) /= zona

lucas = Cliente "Lucas" "Victoria"

daniel = Chofer "Daniel" 23500 [Viaje (20, 4, 2017) lucas 150] (viajeSegunZona "Olivos")

alejandra = Chofer "Alejandra" 180000 [] cualquierViaje

puedeTomarViaje :: Chofer -> Viaje -> Bool
puedeTomarViaje = condicion

liquidacionChofer :: Chofer -> Int
liquidacionChofer = sum . map costo . viajes

sumarViaje :: Viaje -> Chofer -> Chofer
sumarViaje viaje chofer = chofer {viajes = viajes chofer ++ [viaje]}

cuantosViajes :: Chofer -> Int
cuantosViajes = length . viajes

choferConMenosViajes :: [Chofer] -> Chofer
choferConMenosViajes [chofer] = chofer
choferConMenosViajes (chofer1:chofer2:choferes) | cuantosViajes chofer1 <= cuantosViajes chofer2 = chofer1
                                                | otherwise = choferConMenosViajes (chofer2:choferes)

realizarViaje :: Viaje -> [Chofer] -> Chofer
realizarViaje viaje = sumarViaje viaje . choferConMenosViajes . filter (flip puedeTomarViaje viaje)


nito = Chofer "Nito Inly" 70000 (repeat (Viaje (11, 03, 2017) lucas 50)) (viajeSegunNombre 3)

{-No se puede calcular la liquidación debido a que la lista de viajes es infinita, por lo tanto la sumatoria de los costos
también será infinita.
En cuanto a la condición, sabemos que el criterio para tomar el viaje es por el largo del nombre. La cantidad de letras del
nombre Lucas es 5, y siempre es mayor a 3 (requisito para cumplir con la condición), por lo tanto puede tomar el viaje de $500-}

{-Inferir el tipo de la función:

gongNeng :: Ord c => C -> (c -> Bool) -> (a -> c) -> [a] -> c
gongNeng arg1 arg2 arg3 = 
     max arg1 . head . filter arg2 . map arg3
-}