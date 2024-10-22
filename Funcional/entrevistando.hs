data Postulante = UnPostulante {nombre :: String, edad :: Double, remuneracion :: Double, conocimientos :: [String]} deriving Show 

pepe = UnPostulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Wollok", "C"]
tito = UnPostulante "Roberto González" 20 12000.0 ["Haskell", "Php"]

type Nombre = String
data Puesto = UnPuesto {puesto:: String, conocimientoRequeridos :: [String]} deriving Show
jefe = UnPuesto "gerente de sistemas" ["Haskell", "Prolog", "Wollok"]
chePibe = UnPuesto "cadete" ["ir al banco"]
 
apellidoDueno:: Nombre
apellidoDueno = "Gonzalez"
------EJERCICIO 1------
tieneConocimientos :: Puesto -> Postulante -> Bool
tieneConocimientos puesto postulante = all(\requerimiento -> elem requerimiento (conocimientos postulante)) . conocimientoRequeridos $ puesto

