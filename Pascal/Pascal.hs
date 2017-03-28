import Primes
main :: IO ()
main = interact solucion

solucion :: String -> String
solucion = escribeSalida . leeEntrada

leeEntrada :: String -> Int
leeEntrada = read

escribeSalida :: (Integral a, Show a) => a -> [Char]
escribeSalida n =( show (contador n)) ++ "\n"

mayorFactor :: Integral a => a -> a -> a
mayorFactor _ 1 = 1
mayorFactor n x | rem x n == 0 = div x n
                | otherwise = mayorFactor (n+1) x

contador :: Integral a => a -> a
contador n | isPrime n = n-1
           | otherwise = n-1-(mayorFactor 2 n)+1
 

