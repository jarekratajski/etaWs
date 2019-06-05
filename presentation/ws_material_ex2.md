# Exercise 2
Conway's Game of Life

Java eta interoperability

## Game of life

Please go to [exercise2] of cloned etaWs folder.

go to main folder

see the `build.gradle` file

see subfolders etaCode and javaCode


run

`> ./gradlew :javaCode:run`

If You get an error about missing javafx library you have to install it (on ubuntu sudo apt-get install openjfx)



selecting jdk

`> ./gradlew :javaCode:run -Dorg.gradle.java.home=/opt/java/jdk-12`


For jdk 9-12 you may need to uncomment java12 marked  lines.




Check article:

[Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)



If You click on **next** button of **auto**  nothing happens.

Because the game is not yet implemented.


>Any live cell with fewer than two live neighbors dies, as if by underpopulation.
 Any live cell with two or three live neighbors lives on to the next generation.
 Any live cell with more than three live neighbors dies, as if by overpopulation.
 Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.


# Modelling

Go to LifeRule.hs

implement functions:
`decide`,`nextGeneration`

Hint:
Use pattern matching
`decide Alive 3 = Alive`
says that Alive cell that has 2 more neighbours (3 including itself) - will be alive in next generation.
```haskell


Good implementation of nextGeneration is like:
```
nextGeneration::Plane->Plane
nextGeneration !plane =   array (bounds plane) newRows
      where
            rows = assocs plane
            newRows = (\(y,row) -> (y, processRow plane row y)   ) <$> rows

```




## technical problems
`> ./gradlew clean`  cleans the project

`> ./gradlew :etaCode:run`  runs only eta part (nice for debug)




# check the java part

- have fun
- change game of life rules