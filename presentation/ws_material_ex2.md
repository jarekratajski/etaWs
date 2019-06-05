# Exercise 2
Conway's Game of Life

Java eta interoperability

## Game of life

Please go to exercise2 folder.

go to main folder

see the `build.gradle` file


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

add data model:
```
data Cell = Dead | Alive
type Row = Array Int Cell
type Plane = Array Int Row
```

add cell value function (x,y -> 0|1)

```
getCellValue::Plane->Int->Int->Int
getCellValue plane  y x
   | (y >= minBound && y <=maxBound ) = getCellInRow ( plane ! y ) x
   | otherwise = 0
      where
         minBound = fst myBounds
         maxBound = snd myBounds
         myBounds = bounds plane

getCellInRow::Row->Int->Int
getCellInRow row x
   | (x >= minBound && x <=maxBound ) = cellValue $ row ! x
   | otherwise = 0
   where
         minBound = fst myBounds
         maxBound = snd myBounds
         myBounds = bounds row

cellValue Dead = 0
cellValue Alive = 1
```

add counting neighbours
```
countNeighbours::Plane->Int->Int->Int
countNeighbours plane x y = foldl (+) 0 allValues
      where
         rows = [y-1, y, y+1]
         cells = [x-1, x, x+1]
         valuesForY y1 =  (\x -> aRow y1 $  x ) <$> cells
         aRow y1 = getCellValue plane y1
         allValues =  rows >>= valuesForY
```

add processing rows and plane:
```
processRow::Plane->Row->Int->Row
processRow plane row y = array (bounds row) neighbours
      where
            cells = assocs row
            neighbours = ( \(x, cell) -> (x, decide cell (countNeighbours plane x y)) ) <$> cells
```

```
nextGeneration::Plane->Plane
nextGeneration !plane =   array (bounds plane) newRows
      where
            rows = assocs plane
            newRows = (\(y,row) -> (y, processRow plane row y)   ) <$> rows
```

add creation

```
createRow::Int->Row
createRow size = array (0, size) [ (i, Dead) | i <- [0..size]]

createPlane::Int->Int->Plane
createPlane hi wi = array (0, hi) [ (i, createRow wi) | i <- [0..hi]]

setCell::Plane->Int->Int->Cell->Plane
setCell plane x y cell= plane  // [(y, newRow)]
         where
            row = plane ! y
            newRow = row // [(x, cell) ]
```

add debug
```haskell
showRow::Row->String
showRow row =  fmap showCell elemsList
   where elemsList = elems row

showPlane::Plane->String
showPlane plane = foldl (++) ""  stringEndl
      where
         elemsList = elems plane
         strings = fmap showRow elemsList
         stringEndl = fmap (\x -> x ++ "\n")  strings

showCell::Cell -> Char
showCell Dead = '.'
showCell Alive = 'O'

```

goto Main.hs
and type:
```
wi = 40
hi = 20

myPlane = createPlane hi wi

withLine = foldl (\p x -> setCell p x 10 Alive )  myPlane [1..(wi-1)]

main = do
      putStrLn $ showPlane  withLine
      putStrLn $ showPlane  $ nextGeneration withLine
      foldM (\p i -> (putStrLn $ showPlane p )>> return (nextGeneration p) ) withLine  [1..100]
```



# Java exchange

Go to LifeJ.hs  and paste:

```haskell

data Color = Color  {red :: Int,green :: Int, blue :: Int}

cellFromColor::Color->Cell
cellFromColor Color { red = 0, green = 0 , blue = 0 } = Dead
cellFromColor col  = Alive

data JColor = JColor @java.awt.Color
  deriving Class

data WritableImage = WritableImage  @javafx.scene.image.WritableImage
    deriving Class

data PixelWriter = PixelWriter  @javafx.scene.image.PixelWriter
        deriving Class

foreign import java unsafe "getGreen" getGreen
  :: Java JColor Int
foreign import java unsafe "getRed" getRed
    :: Java JColor Int
foreign import java unsafe "getBlue" getBlue
    :: Java JColor Int

foreign import java unsafe "@interface setArgb" setArgb :: PixelWriter->Int->Int->Int->IO  ()
```

Implement Plane as pointer (!)

```haskell
type GOLState = StablePtr Plane

-- create empty plane
initEmptyXP:: Int -> Int -> IO GOLState
initEmptyXP wi hi = newStablePtr $ createPlane wi hi

newStateXP::GOLState -> IO GOLState
newStateXP !state =  ( deRefStablePtr state) >>= (newStablePtr . nextGeneration)

freeStateXP::GOLState->IO ()
freeStateXP state = freeStablePtr state


setCellXP::GOLState->Int->Int->JColor->IO GOLState
setCellXP state x y color = do
                                    red <- javaWith color  getRed
                                    green <- javaWith color  getGreen
                                    blue <- javaWith color getBlue
                                    let color = Color { red = red, green = green , blue  = blue}
                                    let cell  = cellFromColor color
                                    plane <- deRefStablePtr state
                                    newStablePtr $ setCell plane x y cell
```


```haskell
fillImageXP::GOLState->PixelWriter->IO PixelWriter
fillImageXP state image = do
               plane <- deRefStablePtr state
               let rows = assocs plane
               let cells = (\(y, row) -> ( (\(x, cell) -> (x,y,cell) ) <$>assocs row)  ) <$> rows
               let result = foldl ( \img (x,y,cell) -> ioSet x y cell img ) (return image)  (concat cells)
               result

ioSet::Int->Int->Cell->IO PixelWriter->IO PixelWriter
ioSet x y cell image = image >>= (setPixel x y cell )

setPixel::Int->Int->Cell->PixelWriter->IO PixelWriter
setPixel x y cellState  image =   (  setArgb image x y  (cellToRgb cellState) )  >>  return image

white = Color  { red = 255, green = 255 , blue = 255}
black = Color  { red = 0, green = 0 , blue = 0}

cellToRgb Dead = colorToArgb black
cellToRgb Alive = colorToArgb white

colorToArgb::Color->Int
colorToArgb Color{ red = r, green = g,  blue = b} =(shift 255 24) .|. (shift r 16) .|. (shift g 8) .|. b

```

```haskell

foreign export java "@static pl.setblack.life.LifeJ.initEmpty" initEmptyXP
  :: Int -> Int -> IO (GOLState)

foreign export java "@static pl.setblack.life.LifeJ.setCell" setCellXP
   ::GOLState->Int->Int->JColor->IO GOLState

foreign export java "@static pl.setblack.life.LifeJ.newState" newStateXP
   ::GOLState->IO GOLState

foreign export java "@static pl.setblack.life.LifeJ.freeState" freeStateXP
      ::GOLState->IO ()

foreign export java "@static pl.setblack.life.LifeJ.fillImage" fillImageXP
   ::GOLState->PixelWriter->IO PixelWriter

```

## technical problems
`> ./gradlew clean`  cleans the project

`> ./gradlew :etaCode:run`  runs only eta part (nice for debug)




# check the java part

 - have fun
- change game of life rules