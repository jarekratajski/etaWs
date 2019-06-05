# LamdbaConf  2019
Jarek Ratajski 

Workshop materials

#  environment preparation

1. Install java

[Adopt OpenJDK ](https://adoptopenjdk.net/)


`> java -version`

Suggested version: 8


2. Install eta


We  will install eta using etlas.

https://eta-lang.org/docs/user-guides/eta-user-guide/installation/etlas



After installation check installed versions

`> etlas --version`

`> eta --version` 
or 
`> etlas exec eta -- --version`

Write
` etlas exec eta XYZ`

wherever this documentation shows:

`eta XYZ`
 



Later we will install eta  from source.

# Exercise1 (a)

Compilation of simple eta files.


## Exercise 1a  simple eta hello world


Go to folder [exercise1](../exercise1) and try to compile project.

File  Hello.hs should contain lines as below:

```
main = putStrLn "Hello, LambdaConf  2019"
```

Compile `Hello.hs` file

`> eta Hello.hs` 
It will take some time.


`> ls `

Verify what is produced.

`> java -jar RunHello.jar`

Run full java module.

Make some experiment. Have fun.


## Exercise 1 (b) qsort example

lets play with sorting:
create file Qsort.hs with the content below:
```
quicksort [] = []
quicksort (x:xs) = quicksort left ++ [x] ++ quicksort right
    where
          left  = [ y | y <- xs, y < x ]
          right = [ y | y <- xs, y >= x ]

main = do
        let result = quicksort arr
        putStrLn $ show result
        where
            arr = [1,7,9,12,90,1,-1,22,0]

```

`> eta Qsort.hs`

`> ls `

`> java -jar RunQsort.jar`


## etlas

create file hello.cabal

```
name:                 hello-hs
version:              0.1.0.0
author:               you
maintainer:           you
build-type:           Simple
cabal-version:        >=1.10

executable hello-hs
  main-is:              Hello.hs
  build-depends:       base >= 4.7 && < 5
  hs-source-dirs:       .
  default-language:  Haskell2010

```

run
`etlas build`

`etlas run`


## create cabal/etlas file for Qsort



## advanced topics

- do You have your own haskell project?
- can You implement a *real* quick sort?


## Real quicksort

Use this implementation
```
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
        converted = V.toList sorted :: [Int]
    in converted

main = do
                let result = myvsort arr
                putStrLn $ show result
                where
                    arr = [1,7,9,12,90,1,-1,22,0]    

``` 

Changes etlas/cabal file 
add vector dependency
 `build-depends:       base >= 4.7 && < 5, vector`
 
 Vector is a hackage package