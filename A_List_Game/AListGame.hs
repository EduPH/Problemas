import Primes
main :: IO ()
main = interact solucion

solucion :: String -> String
solucion = escribeSalida . leeEntrada
leeEntrada :: String -> Int
leeEntrada = read
escribeSalida :: Int -> String
escribeSalida n = show (length (primeFactors n)) ++ "\n"
