## How  ETA works?



compile haskell sources to bytecode



bytecode runs on a standard JVM



## Intro and documentation

https://eta-lang.org/



Ok that was all, thank you



![Troll](src/images/trollface.png)



## Repo for this workshop
https://github.com/jarekratajski/etaWs

![URL](src/images/url.png)




## Exercise 1a

Hello world



Open:
[ws_material_ex1.md](https://github.com/jarekratajski/etaWs/blob/master/presentation/ws_material_ex1.md)



## Exercise 1b

Quick sort:
[ws_material_ex1.md](https://github.com/jarekratajski/etaWs/blob/master/presentation/ws_material_ex1.md)



# eta compiler

`eta` =~= `ghc` (syntaxx)

`eta` accepts most of compiler options accepted by ghc (v7.x)

`eta` creates jar files



## jar files

[FILE].jar  - only project  code 

`jar tf Hello.jar` 

Run[FILE].jar - full eta runtime +  project code

`jar tf RunHello.jar` 



full (Run) jar is huge and `linking` it is slow



Compile single file - (without `Run*.jar`)
(faster)

`eta -c Hello.hs`



## Build tool

We have more files

We want to use external libraries



## Etlas - cabal

[ws_material_ex1.md](https://github.com/jarekratajski/etaWs/blob/master/presentation/ws_material_ex1.md)



## advanced  exercise (with hackage)



[hackage](https://hackage.haskell.org/)



## We want to implement a `real quicksort`

Go to link:
https://stackoverflow.com/questions/7717691/why-is-the-minimalist-example-haskell-quicksort-not-a-true-quicksort



We need to use something like [vector](https://hackage.haskell.org/package/vector-0.12.0.3/docs/Data-Vector-Generic-Mutable.html)



[ws_material_ex1.md](https://github.com/jarekratajski/etaWs/blob/master/presentation/ws_material_ex1.md)




##  Summary so far
 
`eta` is like `ghc`

`etalas` is like `cabal`

optional exercise - compile all examples with just ghc and/or cabal



# add java



```java
public class HelloWorld 
{
    public static void main(String args[]) 
    { 
        System.out.println("Hello, Lambda Conf"); 
    } 
} 
```

source



```
0000000 feca beba 0000 3400 2200 000a 0006 0914
0000010 1500 1600 0008 0a17 1800 1900 0007 071a
0000020 1b00 0001 3c06 6e69 7469 013e 0300 2928
0000030 0156 0400 6f43 6564 0001 4c0f 6e69 4e65
0000040 6d75 6562 5472 6261 656c 0001 4c12 636f
0000050 6c61 6156 6972 6261 656c 6154 6c62 0165
0000060 0400 6874 7369 0001 4c20 6c70 732f 7465
0000070 6c62 6361 2f6b 7465 6c61 6669 2f65 6548
0000080 6c6c 576f 726f 646c 013b 0400 616d 6e69
0000090 0001 2816 4c5b 616a 6176 6c2f 6e61 2f67
00000a0 7453 6972 676e 293b 0156 0400 7261 7367
00000b0 0001 5b13 6a4c 7661 2f61 616c 676e 532f
00000c0 7274 6e69 3b67 0001 530a 756f 6372 4665
00000d0 6c69 0165 0f00 6548 6c6c 576f 726f 646c
00000e0 6a2e 7661 0c61 0700 0800 0007 0c1c 1d00
00000f0 1e00 0001 4812 6c65 6f6c 202c 614c 626d
0000100 6164 4320 6e6f 0766 1f00 000c 0020 0121
0000110 1e00 6c70 732f 7465 6c62 6361 2f6b 7465
0000120 6c61 6669 2f65 6548 6c6c 576f 726f 646c
0000130 0001 6a10 7661 2f61 616c 676e 4f2f 6a62
0000140 6365 0174 1000 616a 6176 6c2f 6e61 2f67
0000150 7953 7473 6d65 0001 6f03 7475 0001 4c15
0000160 616a 6176 692f 2f6f 7250 6e69 5374 7274
0000170 6165 3b6d 0001 6a13 7661 2f61 6f69 502f
0000180 6972 746e 7453 6572 6d61 0001 7007 6972
0000190 746e 6e6c 0001 2815 6a4c 7661 2f61 616c
00001a0 676e 532f 7274 6e69 3b67 5629 2100 0500
00001b0 0600 0000 0000 0200 0100 0700 0800 0100
00001c0 0900 0000 2f00 0100 0100 0000 0500 b72a
00001d0 0100 00b1 0000 0002 000a 0000 0006 0001
00001e0 0000 0003 000b 0000 000c 0001 0000 0005
00001f0 000c 000d 0000 0009 000e 000f 0001 0009
0000200 0000 0037 0002 0001 0000 b209 0200 0312
0000210 00b6 b104 0000 0200 0a00 0000 0a00 0200
0000220 0000 0600 0800 0700 0b00 0000 0c00 0100
0000230 0000 0900 1000 1100 0000 0100 1200 0000
0000240 0200 1300                              
0000244

```

compiled class (by `javac`)



`jar`  = multiple `.class` files (zipped) 



## Java build tools

maven, gradle



## java libs repositories

[maven central](https://mvnrepository.com/repos/central)



Let's do some java



## Gradle Exercise 2

Game of life 

[ws_material_ex2.md](ws_material_ex2.md)



## Java interchange

Import java class to eta
```
data JColor = JColor @java.awt.Color deriving Class
```

Import java function to eta
```
foreign import java unsafe "getGreen" getGreen 
   :: Java JColor Int
```

Export eta function to java
```
foreign export java "@static pl.setblack.life.LifeJ.setCell" 
   setCellXP :: GOLState->Int->Int->JColor->IO GOLState
```



# Java is a monad



### Eta summary

## Eta =~=  GHC for jvm



## Eta Supports compiler extensions

```haskell
{-# LANGUAGE FlexibleContexts, DataKinds, TypeFamilies, RankNTypes #-}
--  whatever
```



FFI  (C calls) - adapted  for jvm



### Rewritten GHC FFI calls

original GHC `Float.hs` fragment

```
foreign import ccall unsafe "isFloatNaN" isFloatNaN :: Float -> Int
foreign import ccall unsafe "isFloatInfinite" isFloatInfinite :: Float -> Int
foreign import ccall unsafe "isFloatDenormalized" isFloatDenormalized :: Float -> Int
foreign import ccall unsafe "isFloatNegativeZero" isFloatNegativeZero :: Float -> Int
```

Eta `Float.hs` fragment

```
foreign import java unsafe "@static java.lang.Float.isNaN"
  isFloatNaN :: Float -> Bool
foreign import java unsafe "@static java.lang.Float.isInfinite"
  isFloatInfinite :: Float -> Bool
foreign import java unsafe "@static eta.base.Utils.isFloatDenormalized"
  isFloatDenormalized :: Float -> Bool
foreign import java unsafe "@static eta.base.Utils.isFloatNegativeZero"
  isFloatNegativeZero :: Float -> Bool
```



## Eta hackage patches



Project  typelead/hackage ==  patches for common hackage projects



Mostly 1 to 1 native C to Java calls changes.
 
https://github.com/typelead/eta-hackage/blob/master/patches/text-1.2.2.2.patch
 
```
  {-# INLINE equal #-}
  
 -foreign import ccall unsafe "_hs_text_memcpy" memcpyI
 +foreign import java unsafe "@static eta.text.Utils.memcpy" memcpyI
      :: MutableByteArray# s -> CSize -> ByteArray# -> CSize -> CSize -> IO ()
  
 -foreign import ccall unsafe "_hs_text_memcmp" memcmp
 +foreign import java unsafe "@static eta.text.Utils.memcmp" memcmp
      :: ByteArray# -> CSize -> ByteArray# -> CSize -> CSize -> IO CInt
 ```




### Eta is as close as you can get with Haskell/GHC on JVM

Lots of crazy haskell codes that use GHC extensions work on Eta without any problems



# Goto part 2
[Part 2](lconf_part2.html)




