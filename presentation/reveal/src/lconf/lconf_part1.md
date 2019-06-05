## How  ETA works?



compile haskell sources to bytecode



bytecode runs on a standard JVM



## Intro and documentation

https://eta-lang.org/



Ok that was all, thank you



## Exercise 1a

Hello world



Open:
[ws_material_ex1.md](ws_material_ex1.md)



## Exercise 1b

Quick sort:
[ws_material_ex1.md](ws_material_ex1.md)



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

[ws_material_ex1.md](ws_material_ex1.md)



## advanced  exercise - use hackage

We want to implement a `real quicksort`

Go to link:
https://stackoverflow.com/questions/7717691/why-is-the-minimalist-example-haskell-quicksort-not-a-true-quicksort

[ws_material_ex1.md](ws_material_ex1.md)



##  Summary so far
 
`eta` is like `ghc`

`etalas` is like `cabal`

exercise - compile all examples with just ghc and or cabal



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

maven central 



Let's check it



## Gradle Exercise 2

Game of life 

[ws_material_ex2.md](ws_material_ex2.md)




### Eta summary

## Eta =~=  GHC for jvm


## Eta Supports compiler extensions

```haskell
{-# LANGUAGE FlexibleContexts, DataKinds, TypeFamilies, RankNTypes #-}
--  whatever
```

FFI  (C calls) - adapted  for jvm


## Original GHC FFI calls

Eta rewrites those parts to use jvm calls

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




# What about performance?



## Basic optimizations



##  TCO 



Naive fibonacci

```{haskell}
fibnaive  0 = 1
fibnaive  1 = 1
fibnaive  n = fibnaive ( n-1) + fibnaive ( n - 2)
```



better

```{haskell}
fibtcoinner 0 sum presum  = sum
fibtcoinner n sum presum = fibtcoinner  (n-1) (sum + presum) sum

fibtco n = fibbtcoinner n 1 0

```



JVM does not support TCO :-(



![TCO](src/images/tco.jpg)



Java

```{java}
private static BigInteger fibonacci(int n, BigInteger sum, BigInteger presum) {
        if ( n== 0) {
            return sum;
        } else {

            return fibonacci(n-1, sum.add(presum), sum);
        }
    }
```



How much java stands?



~ 10.000

(depends on `-Xss` setting)



Eta
  
```{haskell}
fibtcoinner 0 sum presum  = sum
fibtcoinner n sum presum = fibtcoinner  (n-1) (sum + presum) sum

fibtco n = fibtcoinner n 1 0
``` 

How much this can take?



```haskell
main = print $ show $  fibtco 1000000
```



```{java}
 while(var8) {
     Main.sat_s7YH var12 = new Main.sat_s7YH(var3);
     var1.R1 = var2;
     Closure var13 = Classes.zeze().enter(var1).apply2(var1, (Closure)var9, var12);
     if (!(var13 instanceof False)) {
         return ((Closure)var10).evaluate(var1);
     }

     Main.sat_s7YM var14 = new Main.sat_s7YM(var4, (Closure)var10, (Closure)var11); //this must be sum + presum
     Main.sat_s7YL var15 = new Main.sat_s7YL(var3, (Closure)var9); // this must be n-1
     var9 = var15;    //assign n-1
     var10 = var14;  //assign new sum
     var11 = var14;  //assign presum
     var8 = true;
 }
```



Actually there is a bug above

TCO in `eta` did not work always two years ago



## A task
Fix/Improve TCO in compiler of Haskell written in Haskell (ghc) while learning haskell



![scared](src/images/scared.jpg)



```{Haskell}
       withContinuation unknownCall contCode lastCode
     JumpToIt label cgLocs mLne -> do	     JumpToIt label cgLocs mLne -> do
       traceCg (str "cgIdApp: JumpToIt")	       traceCg (str "cgIdApp: JumpToIt")
-      codes <- getNonVoidArgCodes args	+      deps <- dependencies cgLocs args
-      emit $ multiAssign cgLocs codes	+      let sorted = sortedDeps deps
+      codes <- getNonVoidArgCodes $ arg <$> sorted
+      emit $ multiAssign (from <$> sorted) codes
           <> maybe mempty	           <> maybe mempty
                (\(target, targetLoc) ->	                (\(target, targetLoc) ->
                   storeLoc targetLoc (iconst (locFt targetLoc) $ fromIntegral target))	                   storeLoc targetLoc (iconst (locFt targetLoc) $ fromIntegral target))
                mLne	                mLne
           <> goto label	           <> goto label
 	 
+data LocalDep = LocalDep Int Int
+{-
+type CgBindings = IdEnv CgIdInfo
+-- | Variable Environment
+type VarEnv elt     = UniqFM elt
+
+-- | Identifier Environment
+type IdEnv elt      = VarEnv elt
+newtype UniqFM ele = UFM (M.IntMap ele)
+
+-}
+data CgDependency = CgDependency { from::CgLoc, to:: CgLoc, arg::StgArg } -- deriving (Show)
+
+sortedDeps deps = ( \(node,b,c) -> node)  <$> ( map vertexToNode $ G.topSort myGraph )
+        where (myGraph,vertexToNode,keyToVertex) = G.graphFromEdges $  (\x -> (x, show $ from x ,[show $ to x])) <$> deps
+
+dependencies::[CgLoc]->[StgArg]->CodeGen [CgDependency]
+dependencies locs [] =  pure []
+dependencies (y:ys) (x:xs) = dependencies ys xs  >>=  joinDependency y x
+dependencies _ _ = pure []
+
+joinDependency  loc x deps =
+    joinSingle x loc deps  <$> dep
+    where dep = dependency x
+
+joinSingle arg loc deps Nothing = deps
+joinSingle arg loc deps (Just x) = CgDependency{from=loc, to=x, arg=arg}:deps
+
+dependency::StgArg->CodeGen (Maybe CgLoc)
+dependency arg = getGetDepCgLoad (NonVoid arg)
+
+getGetDepCgLoad :: NonVoid StgArg -> CodeGen (Maybe CgLoc)
+getGetDepCgLoad (NonVoid (StgVarArg var)) = Just <$> cgLocation <$> getCgIdInfo var
+getGetDepCgLoad (NonVoid (StgLitArg literal)) = return Nothing
+
```



![having a help](src/images/help.png)<!-- .element style="height: 500px" -->

With a help of main Eta developer it was not that hard 
It was fun



```
 while(var8) {
     Main.sat_s7YH var12 = new Main.sat_s7YH(var3);
     var1.R1 = var2;
     Closure var13 = Classes.zeze().enter(var1).apply2(var1, (Closure)var9, var12);
     if (!(var13 instanceof False)) {
         return ((Closure)var10).evaluate(var1);
     }

     Main.sat_s7YM var14 = new Main.sat_s7YM(var4, (Closure)var10, (Closure)var11); //this must be sum + presum
     Main.sat_s7YL var15 = new Main.sat_s7YL(var3, (Closure)var9); // this must be n-1
     var11 = var10;  //assign presum
     var10 = var14;  //assign new sum
     var9 = var15;    //assign n-1
     var8 = true;
 }       
``` 



## Performance



-  JMH
- Quick sort implementations exported and called from java
- naive and real quicksort
- compared to same solutions in Java (using vavr.io)
- not very professional  - just to get some overview



Naive quicksort Eta

```{haskell}
quicksort [] = []
quicksort (x:xs) = quicksort left ++ [x] ++ quicksort right
    where
          left  = [ y | y <- xs, y < x ]
          right = [ y | y <- xs, y >= x ]

```

Naive quicksort Java/vavr
```{java}
       private List<Integer> qsort(List<Integer> input) {
           if (!input.isEmpty()) {
               final int middle =  input.head();
               final List<Integer> left = input.tail().filter( x -> x <= middle);
               final List<Integer> right = input.tail().filter( x -> x > middle);
               return qsort(left).appendAll(qsort(right).prepend(middle));
           } else {
               return input;
           }
       }
```



Real quicksort ETA

```{haskell}
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
   mklist ::  VList JInteger -> IO [Int] --needed for Java interrop
   mklist li =  do
           empty <-  javaWith li visEmpty
           if  empty
           then  return []
           else     (javaWith li vhead ) >>=(\x -> return [fromJava x])       
```



Real ~~quick~~sort Java (*)

```{java}
   list.sort(); // :-)

```



[https://github.com/jarekratajski/eta-sort-bm](https://github.com/jarekratajski/eta-sort-bm)



Results

![Sort performance](src/images/qs_performance.png)



# vs other *Haskells*



12 Queens

```{haskell}
   {-# LANGUAGE BangPatterns #-}
   
   -- solution by Oystein Kolsrud
   -- https://www.youtube.com/watch?v=I2tMmsZC1ZU
   okToAdd :: Int -> [Int] -> Bool
   okToAdd q qs = all (okToAddDirection q qs) [succ, pred, id]
       where
           okToAddDirection q qs f = and $ zipWith (/=) (tail (iterate f q)) qs
   
   extendSolution n qs = map (\q -> q:qs) $ filter (\q -> okToAdd q qs) [1..n]
   
   allSolutions !n 0 = [[]]
   allSolutions !n k = concatMap (extendSolution n) (allSolutions n (k-1))
   
   
   main = do
        putStr "12 Queens, "
        putStr (show $ length $ allSolutions 12 12)
        putStr " Solutions.\n"

```



|Implementation| Task |Solutions | Time (real)|
|--|--|--|--|
|Frege| 12 Queens | 14200 Solutions|     (*)45.816s|
|Eta| 12 Queens| 14200 Solutions |    (*)26.472s |
|Ghc| 12 Queens|  14200 Solutions |   9.806s|

`*` Unfair benchmark - both Frege and Eta were measured with JVM startup time



Other benchmarks

[https://github.com/jbgi/partial-evaluation](https://github.com/jbgi/partial-evaluation)



#  Java Interopability 



## JWT - java types

```{haskell}
data JColor = JColor @java.awt.Color
  deriving Class
```



## foreign import

```{haskell}

foreign import java unsafe "getGreen" getGreen
  :: Java JColor Int

```



Java  is a *Monad*.

```haskell
-- Execute a Java action in the IO monad.
java :: Java c a -> IO a

-- Execute a Java action in the IO monad with respect to the
-- given object.
javaWith :: (Class c) => c -> Java c a -> IO a

-- Execute a Java action in the Java monad of another class
-- with respect to the given object.
(<.>) :: (Class c) => c -> Java c a -> Java b a
withObject :: (Class c) => c -> Java c a -> Java b a

-- Chain Java actions.
(>-) :: (Class b) => Java a b -> Java b c -> Java a c

-- Execute an IO action inside of the Java monad
io :: IO a -> Java c a

-- Execute a Java action purely, i.e. order of execution does not matter.
pureJava :: Java c a -> a

-- Analagous to `javaWith`, but pure.
pureJavaWith :: (Class c) => c -> Java c a -> a
```



## foreign export

```{haskell}
foreign export java "@static eta.example.MyExportedClass.sort"
   sort :: JIntArray -> JIntArray

```



# Styles of interoperability



## Full Haskell way

Example:
[WAI Servlet](https://github.com/jneira/wai-servlet)
```{haskell}
appAll :: FilePath -> Application
appAll filePath req respond = case pathInfo req of
  ["state"]        -> appState (unsafePerformIO $ newMVar 0) req respond
  ["stream"]       -> appStream req respond
  ["request-info"] -> appShowReq req respond
  ["static-file"]  -> appFile filePath req respond
  _                -> appSimple req respond
```



## Classes in java logic in haskell

- Types defined in java
- Haskell functions work on Java objects
- Support and use of Java frameworks, serializations, db bindings, jsons.



![swapped](src/images/pongcheck.png)<!-- .element style="height: 500px" -->



```{java}
@JsonDeserialize
public class Ball extends GameObject {
    private static final long serialVersionUID = 1L;
    public final Vector2D speed;

    @JsonCreator
    public Ball(float x, float y, Vector2D speed) {
        super(x, y);
        this.speed = speed;
    }
```



```{java}
@JsonDeserialize
public class GameState implements Serializable {
    private static final long serialVersionUID = 1L;
    public final GamePhase phase;
    public final Ball ball;
    public final Players players;
    public final long updateTime;

    @JsonCreator
    public GameState(
            final Ball ball,
            final Players players,
            final long updateTime) {
        this.ball = ball;
        this.players = players;
        this.updateTime = updateTime;
        this.phase = players.phaseFromScore();
    }
```



```{haskell}
foreign import java unsafe "@new" newGameState  :: Ball.Ball -> Players.Players -> Int64 -> GameState

foreign import java unsafe "@field phase" phase :: GameState -> GamePhase.GamePhase

foreign import java unsafe "@field ball" ball :: GameState -> Ball.Ball

foreign import java unsafe "@field players" players :: GameState -> Players.Players

foreign import java unsafe "@field updateTime" updateTime :: GameState -> Int64

push::GameState->Int64->J.Random->IO GameState
push state time rnd
         | (aPhase == GamePhase.started ) = pushStarted state time rnd
         | otherwise  =  return state
         where aPhase = phase state
```



Linguistic determinism



![snow](src/images/snow.jpeg)<!-- .element height="500" -->

<small>from http://postcogtopics.blogspot.com/2016/</small>



```{java}
    //A piece of smart code in Players should reduce both methods code duplication
    private Tuple2<Ball, Players> bouncePlayer1(final Players players, final Random rnd) {
        if (this.x < 0 && speed.x < 0) {
            if (isTouchingPaddle(players.player1.paddle, this.y)) {
                return Tuple.of(new Ball(0f, this.y, this.speed.bounceX()), players);
            } else {
                return Tuple.of(Ball.randomDirection(rnd), players.mapPlayer(2, pl2 -> pl2.score()));
            }
        }
        return Tuple.of(this, players);
    }

    private Tuple2<Ball, Players> bouncePlayer2(final Players players, final Random rnd) {
        if (this.x > 1.0f && speed.x > 0) {
            if (isTouchingPaddle(players.player2.paddle, this.y)) {
                return Tuple.of(new Ball(1f, this.y, this.speed.bounceX()), players);
            } else {
                return Tuple.of(Ball.randomDirection(rnd), players.mapPlayer(1, pl1 -> pl1.score()));
            }
        }
        return Tuple.of(this, players);
    }
```



```{haskell}
bouncePlayerInternal::Ball->Players.Players->J.Random->(Lens' Players.Players Player.Player)->(Lens' Players.Players Player.Player)->Float->IO (Ball, Players.Players)
bouncePlayerInternal ball players rnd lens opLens  xposition
      | (isTouchingPaddle paddle thisY) = return (newBall xposition thisY (Vector2D.bounceX thisSpeed), players)
      | otherwise = do
         randomBall <- randomDirection rnd
         return ( randomBall, set opLens  opponentScored players)
   where
      thisX = xObj ball
      thisY = yObj ball
      thisSpeed = speed ball
      speedX = Vector2D.x thisSpeed
      playerView = view lens players
      opponentScored = Player.incScore $ view opLens players
      paddle = Player.paddle playerView
```



# Hava

`ballBounceP :: Ball.Ball -> Players.Players -> J.Random -> IO Players.Players`



![hava](src/images/hava.jpeg)



## pointer ref  way 

Data in haskell, business logic in haskell
 
Java as Controller



We need to expose haskell *objects* to java. 



Game of life

```{haskell}
data Color = Color  {red :: Int,
                                                             green :: Int,
                                                             blue :: Int};

data  Cell  = Dead | Alive {color :: Color}

type Row = Array Int Cell
type Plane = Array Int Row

type GOLState = StablePtr Plane

initEmptyXP:: Int -> Int -> IO GOLState
initEmptyXP wi hi = newStablePtr $ makePlane wi hi

newStateXP::GOLState -> IO GOLState
newStateXP state =  ( deRefStablePtr state) >>= (newStablePtr . processPlane)

foreign export java "@static pl.setblack.life.Life.newState" newStateXP
   ::GOLState->IO GOLState
```

```{java}
    public static int newState(int var0) {
        return ((StablePtr)Runtime.evalIO(new Ap2Upd(TopHandler.runIO(), new Ap2Upd(Main.$fe_newStateXP(), new StablePtr(var0))))).x1;
    }
```



## problems

- lot of imports to write for every  simple java class
   - this will be fixed thanks to `ffi tool`
- it took me a while to find out how to pass state between haskell and java
- other bug found (and resolved)
- java monad / io monad - not totally intuitive (for a newbie) 



## Eta vs Frege



I used Frege very shortly

- **Frege** is more mature compiler
- Interoperation with Java is easier with Frege
- Frege will not be close to GHC in the near future
   - at the semantics level
   - at the libraries level   
-  Eta provides more tools (gradle plugin, etlas etc.)



# Eta for you



## Eta now

Eta version today is 0.8.6b5



If You think of eta in production soon -> talk to **Typelead**

They want to provide commercial support - ask them for conditions  



If you are haskell developer that wants to evaluate haskell on JVM

*Try it now!*



 If you are JVM / JavaDeveloper that wants to learn and play with Haskell

*Play now!* 



# Eta community



Small



Great!



You can help! There are lot of small things to do




Even if You stick to Java 

learning Haskell can help You improve java skills

You may accidentally understand the `M...` word


