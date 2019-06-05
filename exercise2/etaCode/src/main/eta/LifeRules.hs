{-# LANGUAGE BangPatterns #-}
module LifeRules where

import Data.Array
import Data.Maybe

data Cell = Dead | Alive
type Row = Array Int Cell
type Plane = Array Int Row

-- tell if a cell of a given state (Dead|Alive) is Dead or ALive in next generation (having X neighbours  - a cell is included)
decide::Cell->Int->Cell
decide _ _ = Dead


-- create next Plane (game state)
nextGeneration::Plane->Plane
nextGeneration !plane =  plane  -- TODO this is obviously wrong


countNeighbours::Plane->Int->Int->Int
countNeighbours plane x y = foldl (+) 0 allValues
      where
         rows = [y-1, y, y+1]
         cells = [x-1, x, x+1]
         valuesForY y1 =  (\x -> getCellValue plane x y1 ) <$> cells
         allValues =  rows >>= valuesForY

processRow::Plane->Row->Int->Row
processRow plane row y = array (bounds row) neighbours
      where
            cells = assocs row
            neighbours = ( \(x, cell) -> (x, decide cell (countNeighbours plane x y)) ) <$> cells



-- some utility function You can use (you do not have to)
getCellValue::Plane->Int->Int->Int
getCellValue plane x y
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


-- this is construction part - java uses those functions
-- to create initial state of game
-- bindings to java are defined in LifeJ

createRow::Int->Row
createRow size = array (0, size) [ (i, Dead) | i <- [0..size]]

createPlane::Int->Int->Plane
createPlane hi wi = array (0, hi) [ (i, createRow wi) | i <- [0..hi]]

setCell::Plane->Int->Int->Cell->Plane
setCell plane x y cell= plane  // [(y, newRow)]
         where
            row = plane ! y
            newRow = row // [(x, cell) ]



-- show / debug functions

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


