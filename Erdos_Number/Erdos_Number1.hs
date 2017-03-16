import Data.Graph
import Data.List
import qualified Data.Map as Map
main :: IO ()
main = interact solucion


solucion :: String -> String
solucion = escribeSalida . leeEntrada

leeEntrada :: String -> [[String]]
leeEntrada = map words .lines

escribeSalida :: [[[Char]]] -> [Char]
escribeSalida xss =concat  (representa' xss (creaGrafo xss) (creaDiccionario xss))

-- λ> autores ls
-- ["PAUL_ERDOS","HARVEY_ABBOTT","JANOS_ACZEL","TAKASHI_AGOH","RON_AHARONI","MARTIN_AIGNER","MIKLOS_AJTAI","CHARLES_AULL","EZRA_BROWN","PAUL_DIERKER","MATTS_ESSEN","FRANK_BROWN","CHARLES_ROGERS"]

autores :: (Eq a, Foldable t) => t [a] -> [a]
autores = nub . concat 

-- λ> enumeraAutores ls
-- [("PAUL_ERDOS",1),("HARVEY_ABBOTT",2),("JANOS_ACZEL",3),("TAKASHI_AGOH",4),("RON_AHARONI",5),("MARTIN_AIGNER",6),("MIKLOS_AJTAI",7),("CHARLES_AULL",8),("EZRA_BROWN",9),("PAUL_DIERKER",10),("MATTS_ESSEN",11),("FRANK_BROWN",12),("CHARLES_ROGERS",13)]

enumeraAutores :: (Enum b, Eq a, Num b, Foldable t) => t [a] -> [(a, b)]
enumeraAutores xss = zip (autores xss) [1..]

sustAutorPorNum :: Eq a => [a] -> [(a, t)] -> [t]
sustAutorPorNum [] ns = []
sustAutorPorNum (x:xs) ns = (val x ns):(sustAutorPorNum xs ns)

creaDiccionario :: (Enum a, Num a, Ord k, Foldable t) => t [k] -> Map.Map k a
creaDiccionario  xss = Map.fromList (enumeraAutores xss)

val :: Eq a1 => a1 -> [(a1, a)] -> a   
val x ns = head [n | (a,n) <- ns, a== x]


-- Trabajo con Grafos:

creaListGrafo :: Eq a => [[a]] -> [(a, t)] -> [[t]]
creaListGrafo [] ns = []
creaListGrafo (xs:xss) ns = (sustAutorPorNum xs ns):(creaListGrafo xss
                                                                   ns)
preparaGrafo :: [t] -> [(t, t)]
preparaGrafo (x:xs) = [(x,y)| y <- xs]

prepGraf :: [[t]] -> [[(t, t)]]
prepGraf = map preparaGrafo


creaGrafo :: Eq a => [[a]] -> Graph
creaGrafo xss = 
    buildG (1,length (autores xss)) (concat (prepGraf ((creaListGrafo
                                                        xss) (enumeraAutores xss))))

antecesores :: Vertex -> Graph -> [Vertex]
antecesores n g = [a | (a,b) <- edges g, b== n]

-- Número de Erdos

conectado :: [Char] -> Graph -> Map.Map [Char] Vertex -> Bool
conectado x g dc = path g (aux (Map.lookup "PAUL_ERDOS"
                                   dc)) (aux (Map.lookup x dc))
    where
      aux (Just m) = m

--num_Erdos :: (Num a, Ord a) => Vertex -> [[[Char]]] -> a
num_Erdos v g dc xss | v == (aux pe) = 0
                     | elem (aux pe) (antecesores v g) = 1
                     | otherwise = 1+ minimum [num_Erdos y g dc xss | y <- (antecesores v g)] 
               where
                 g = creaGrafo xss
                 pe = Map.lookup "PAUL_ERDOS" dc
                 aux (Just n) = n
                            

-- Representación de los datos:

representa' :: [[[Char]]] -> Graph -> Map.Map [Char] Vertex -> [[Char]]
representa' xss g dc = [representa xs g xss dc | xs <- xss]

representa :: [[Char]] -> Graph -> [[[Char]]] -> Map.Map [Char] Vertex -> [Char]
representa (x:xs) g xss dc | conectado x g dc = x++ " " ++ show
                                                (num_Erdos (aux n) g dc
                                                           xss) ++ "\n"
                           | otherwise = x ++ " " ++ "no-connection"++"\n"
                           where
                             n = Map.lookup x dc
                             aux (Just m) = m
