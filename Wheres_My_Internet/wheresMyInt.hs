import Data.Graph
import Data.List
main :: IO ()
main = interact solucion

solucion :: String -> String
solucion = escribeSalida . leeEntrada

leeEntrada :: String -> [(Int,Int)]
leeEntrada xss = 
    (pares (map read (head ls))):[ pares (sort (map read xs)) | xs <- tail ls]
    where
      listas = map words . lines
      ls = listas xss
      pares xs = (head xs,last xs)
               
escribeSalida :: [(Int,Int)] -> String
escribeSalida xs | xs' == []  = "Connected" ++ "\n"
                 | otherwise = aux xs'
                 where
                   g = creaGrafo xs
                   xs' = sinInternet g
                   aux [] = ""
                   aux (x:xs) = show x ++ "\n" ++ aux xs

creaGrafo :: [(Vertex, Vertex)] -> Graph
creaGrafo ((n,m):xs) = buildG (1,n) (aux xs)
    where
      aux [] = []
      aux ((a,b):xs) = (a,b):(b,a):(aux xs)

conInternet :: Graph -> Vertex -> Bool
conInternet g x = path g x 1 || path g 1 x

sinInternet :: Graph -> [Vertex]
sinInternet g = [ x | x <- vertices g, not (conInternet g x)]


