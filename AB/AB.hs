import Data.List
import Data.Array
main :: IO ()
main = interact solucion

solucion :: String -> String
solucion = escribeSalida . leeEntrada
leeEntrada :: String -> [Int]
leeEntrada xs = map read ((map words (lines xs)) !! 1)
escribeSalida :: [Int] -> String
escribeSalida xs = show (abProb' (creaArray xs)) ++ "\n"

creaArray xs = listArray (1,n) xs
    where
      n = length xs
abProb' r =  length [(r!i,r!j,r!k) | i <- [1..length r], 
                     j <- (delete i [1..length r]),
                     k <-(delete j (delete i [1..length r])), 
                     r!i+r!j== r!k] 
