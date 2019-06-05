{-# LANGUAGE MultiParamTypeClasses #-}
module Main where

import GHC.Base(Class)
import Java (Java, maybeToJava, JavaConverter, toJava, fromJava)


main :: IO ()
main = putStrLn "Hello, Eta!"

data HTest = HTest @my.HTest deriving Class
foreign import java unsafe "@new" newHTest  :: Java a HTest

foreign export java "@static my.HTest.mkHTest" mkHTest :: Int -> Java a (Maybe HTest)
mkHTest 0 = return $  Nothing
mkHTest _ = Just <$> newHTest

foreign export java "@static my.HTest.mkHTest3" mkHTest3 :: Int -> Java a (Maybe HTest)
mkHTest3 _ = Just <$> newHTest


foreign export java "@static my.HTest.mkHTest4" mkHTest4 :: Int -> Java a (Maybe HTest)
mkHTest4 _ = return Nothing
