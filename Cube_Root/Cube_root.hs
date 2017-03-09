main :: IO ()
main = interact solucion


solucion :: String -> String
solucion = escribeSalida . leeEntrada

leeEntrada :: String -> [Integer]
leeEntrada = map read. words

escribeSalida :: (Integral a, Show a) => [a] -> [Char]
escribeSalida [] = ""
escribeSalida (x:xs) = (show (mejorAproxRaiz (intervalos (0,x) x) x)) ++
                       "\n" ++ escribeSalida xs


paso :: Integral t => (t, t) -> t -> (t, t)
paso (x,y) z | ((div (x+y) 2)^3) >= z =  (x, div (x+y) 2) 
             | otherwise  =   (div (x+y) 2,y)

intervalos :: Integral t => (t, t) -> t -> (t, t)
intervalos (x,y) z | abs (x-y) == 1 = (x,y)
                   | otherwise = intervalos (paso (x,y) z) z

mejorAproxRaiz :: (Num a, Ord a) => (a, a) -> a -> a
mejorAproxRaiz (x,y) z | abs (x*x*x-z) < abs (y*y*y-z) = x
                       | otherwise = y
