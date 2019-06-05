import qualified Data.Vector.Generic as G
import qualified Data.Vector  as V
import qualified Data.Vector.Generic.Mutable as M

qvsort :: (G.Vector v a, Ord a) => v a -> v a
qvsort = G.modify go where
    go xs | M.length xs < 2 = return ()
          | otherwise = do
            p <- M.read xs (M.length xs `div` 2)
            j <- M.unstablePartition (< p) xs
            let (l, pr) = M.splitAt j xs
            k <- M.unstablePartition (== p) pr
            go l; go $ M.drop k pr


myvsort ::[Int] ->[Int]
myvsort li =
    let vec = V.fromList li :: (V.Vector Int)
        sorted = qvsort vec :: (V.Vector Int)
        converted = V.toList soted :: [Int]
    in converted


main = do
                let result = myvsort arr
                putStrLn $ show result
                where
                    arr = [1,7,9,12,90,1,-1,22,0]