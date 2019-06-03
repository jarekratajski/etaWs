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


Later we will install eta  from source.

# Exercise1 

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


## Exercise 1b qsort example

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
author:               jarekratajski
maintainer:           jratajski@gmail.com
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


# create cabal/etlas file for Qsort



## advanced topics

- do You have your own haskell project?
- can You implement a *real* quick sort? 


# Exercise 2

Java eta interoperability

## Game of life

Please go to exercise2 folder.

go to main folder

`> ./gradlew run`

If You get an error about missing javafx library you have to install it (on ubuntu sudo apt-get install openjfx)


Check article:

[Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

If You click on **next** button of **auto**  nothing happens.

Because the generation of a next plane is ... simplified.

```
nextGeneration::Plane->Plane
nextGeneration plane =  plane
```

Check defeintions of `Cell`, `Plane`, `Row` and try to write rules for a game.

>Any live cell with fewer than two live neighbors dies, as if by underpopulation.
 Any live cell with two or three live neighbors lives on to the next generation.
 Any live cell with more than three live neighbors dies, as if by overpopulation.
 Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.


## technical problems
`> ./gradlew clean`  cleans the project

`> ./gradlew :run`  runs only eta part (nice for debug)

## advanced

The game runs relatively slow. 
Can You make it faster?



## TODOS alternative
- better frame
- prepare game pong
- comments
-
