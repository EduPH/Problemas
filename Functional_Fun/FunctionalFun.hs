import Data.List
main :: IO ()
main = interact solucion

solucion :: String -> String
solucion = escribeSalida . leeEntrada

-- λ>  (leeEntrada "domain 1 2 3 4 5 \ncodomain 1 4 16 \n3\n 1 -> 1\n 2 -> 4 \n4 -> 16")
-- [(["1","2","3","4","5"],["1","4","16"],[('1','1'),('2','2'),('4','4')])]

leeEntrada :: String -> [([String], [String], [(String, String)])]
leeEntrada = particion . map words . lines

particion :: [[String]] -> [([String], [String], [(String, String)])]
particion [] = []
particion (x:y:z:xs) = 
    (tail x,tail y, map aux (take (read (head z)) xs))
    : particion (drop (read (head z) )xs)
    where
      aux xs = (head xs,last xs)
      

escribeSalida :: (Eq a, Eq a1, Foldable t) => [(t1, t a, [(a1, a)])] -> [Char]
escribeSalida [] = ""
escribeSalida (x:xs) = tipoFuncion x ++ escribeSalida xs



-- λ> dominio ([1,2,3,4,5],[1,4,16],[(1,1),(2,4),(4,16)])
-- [1,2,3,4,5]

dominio :: (t, t1, t2) -> t
dominio (xs,_,_) = xs

-- λ> recorrido ([1,2,3,4,5],[1,4,16],[(1,1),(2,4),(4,16)])
-- [1,4,16]

recorrido :: (t, t1, t2) -> t1
recorrido (_,ys,_) = ys

-- λ> imagenes ([1,2,3,4,5],[1,4,16],[(1,1),(2,4),(4,16)])
-- [(1,1),(2,4),(4,16)]

imagenes :: (t, t1, t2) -> t2
imagenes (_,_,zs) = zs

-- λ> esFuncion ([1,2,3,4,5],[1,4,16],[(1,1),(2,4),(4,16)])
-- True

esFuncion :: Eq b => (t, t1, [(b, b1)]) -> Bool
esFuncion xs = map fst (imagenes xs) == nub (map (fst) (imagenes xs))

-- λ> esInyectiva ([1,2,3,4,5],[1,4,16],[(1,1),(2,4),(4,16)])
-- True

esInyectiva :: Eq b => (t, t1, [(a, b)]) -> Bool
esInyectiva xs = map snd (imagenes xs) == nub ( map snd (imagenes xs))


-- λ> esSobreyectiva ([1,2,3,4,5],[1,4,16],[(1,1),(2,4),(4,16)])
-- True

esSobreyectiva :: (Eq a, Foldable t) => (t1, t a, [(a1, a)]) -> Bool
esSobreyectiva xs =  pertenece (recorrido xs) (map snd (imagenes xs)) 
    where
      pertenece xs ys = all (`elem` ys) xs

-- λ> tipoFuncion ([1,2,3,4,5],[1,4,16],[(1,1),(2,4),(4,16)])
-- "bijective \n"

tipoFuncion :: (Eq a, Eq a1, Foldable t) => (t1, t a, [(a1, a)]) -> [Char]
tipoFuncion xs | not (esFuncion xs) = "not a function\n"
               | esInyectiva xs && esSobreyectiva xs = "bijective\n"
               | esInyectiva xs = "injective\n"
               | esSobreyectiva xs = "surjective\n"
               | otherwise = "neither injective nor surjective\n"
