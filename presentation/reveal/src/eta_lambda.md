![Eta](/src/images/eta.jpeg)<!-- .element class="center" -->



##  Jarek Ratajski

@jarek000000

Loves programming since the first line I wrote for C64

Anarchitect @ Engenius GmbH

Java developer (since 1999) with a functional  heart




## Origin


Lots of developers that love Haskell

![Haskell](/src/images/haskell.png)<!-- .element class="center" -->


but when it comes to business...

![Industry](/src/images/industry.jpg)<!-- .element class="center" -->


![Java](/src/images/onlyjava.jpg)<!-- .element class="center" -->


## JVM is a monster

 - Dynamic/ Just in time compilation is powerful
 ( add -XX:+PrintCompilation to jvm to see ow it works)
 (or -XX:+PrintAssembly  - needs debug version of JVM)
 - aggressive inlining
 - escape analysis
 - uses (SIMD*) etc.
 - Each new version is faster (jdk8, jdk9, jdk10)
 - New advanced garbage collectors (G1GC, ZGC. Shenandoah)
 - New Just in time compiler (Graal)

 


###  Solutions


## write *Haskell* using Java

```{java}
            return List.ofAll(iterableRead)
                    .foldLeft(HashMap.<String, Topic>empty(),
                            (existingMap, newElement) ->
                                    existingMap.put( newElement.topic,
                                            existingMap.get( newElement.topic)
                                                    .getOrElse(Topic.create(newElement.topic))
                                                    .addMessage(newElement.message))
                                    );
        } catch (IOException e) {
            return HashMap.<String, Topic>empty();
        }

```


## write *Haskell* using Scala

```{scala}

  implicit val treeApplicative: Applicative[Tree] = new Applicative[Tree] {
    def point[A](a: => A): Tree[A] = Tree(a, Seq.empty)

    def ap[A, B](fa: => Tree[A])(tf: => Tree[A => B]): Tree[B] = {
      val Tree(f, tfs) = tf

      Tree(f(fa.root), fa.children.map(t => t.map(f)) ++ tfs.map(t => fa <*> t))
     }
   }

```
From https://github.com/fosskers/scalaz-and-cats


## write Haskell using Haskell (ETA)
![Mind blown](/src/images/tim-and-eric-mind-blown.gif)<!-- .element class="center" -->


deploy to JVM


glue with Java



# Typelead

Company founded to create eta and in the future provide commercial support for it.


I am not associated with Typelead


Whatever I say or show here are mine own studies. I got help from typelead developers and eta community.

I am neither experienced haskell nor eta developer. 

What I say might be wrong or may not reflect the reality or the future. 

I just tried to do my best.


We talk about not finished product.


# Eta 1.2.3 intro


## Quicksort(*)

```{haskell}
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

```
$ eta Main.hs

$ java -jar Main.jar
```

```
[-1,0,1,1,7,9,12,22,90]
```


## Etlas (cabal for Eta)

```
$ etlas init

$ etlas build

$ etlas run

```


For more info see [Eta tour](https://tour.eta-lang.org/)  page

![Haskell](/src/images/eta_tour.png)<!-- .element class="center" -->



### Eta special

## Eta =~=  GHC for jvm


backend for GHC  -> great compatibility


STG machine

```
Fibb.fibbtcoinner
  :: forall a_a7U9 a1_a7UA.
     (GHC.Classes.Eq a_a7U9, GHC.Num.Num a_a7U9, GHC.Num.Num a1_a7UA) =>
     a_a7U9 -> a1_a7UA -> a1_a7UA -> a1_a7UA
[GblId,
 Arity=6,
 Caf=NoCafRefs,
 Str=<S(C(C(S))L),U(C(C1(U)),A)><L,U(A,C(C1(U)),A,A,A,A,C(U))><L,U(C(C1(U)),A,A,A,A,A,A)><L,U><L,U><L,U>,
 Unf=OtherCon []] =
    \r srt:SRT:[] [$dEq_s8MJ
                   $dNum_s8MK
                   $dNum1_s8ML
                   eta_s8MM
                   eta1_s8MN
                   eta2_s8MO]
        let {
          lvl1_s8MP [Occ=OnceL] :: a_a7UF
          [LclId, Str=] =
              \u srt:SRT:[] []
                  GHC.Num.fromInteger $dNum_s8MK Fibb.fibbnaive3; } in
        let {
          lvl2_s8MQ [Occ=OnceL] :: a_a7UF
          [LclId, Str=] =
              \u srt:SRT:[] [] GHC.Num.fromInteger $dNum_s8MK Fibb.fibbnaive1;
        } in 
          let-no-escape {
            fibbtcoinner1_s8MR [Occ=LoopBreaker]
              :: a_a7UF -> a1_a7UG -> a1_a7UG -> a1_a7UG
            [LclId, Arity=3, Str=<L,U><L,U><L,U>, Unf=OtherCon []] =
                sat-only \r srt:SRT:[] [ds_s8MS sum_s8MT presum_s8MU]
                    case GHC.Classes.== $dEq_s8MJ ds_s8MS lvl2_s8MQ of _ [Occ=Dead] {
                      GHC.Types.False ->
                          let {
                            sat_s8MX [Occ=Once] :: a1_a7UG
                            [LclId, Str=] =
                                \u srt:SRT:[] [] GHC.Num.+ $dNum1_s8ML sum_s8MT presum_s8MU; } in
                          let {
                            sat_s8MW [Occ=Once] :: a_a7UF
                            [LclId, Str=] =
                                \u srt:SRT:[] [] GHC.Num.- $dNum_s8MK ds_s8MS lvl1_s8MP;
                          } in  fibbtcoinner1_s8MR sat_s8MW sat_s8MX sum_s8MT;
                      GHC.Types.True -> sum_s8MT;
                    };
          } in  fibbtcoinner1_s8MR eta_s8MM eta1_s8MN eta2_s8MO;
```


## spineless, tagless G-machine


## STG
*...It defines how the Haskell evaluation model should be efficiently implemented on standard hardware. ...*


STG  =~= (*bytocode* or llvm)


## 1st phase hs to STG
Eta compiler in a phase **.hs to STG**

..is simply a GHC code! (forked)


## 2nd phase  - STG to Bytecode / JVM


``` 
0: getstatic     #127                // Field DZMZN:Leta/runtime/stg/Closure;
3: ifnull        9
6: goto          35
9: ldc           #3                  // class ghc_prim/ghc/Types
11: dup
12: astore_0
13: monitorenter
14: getstatic     #127                // Field DZMZN:Leta/runtime/stg/Closure;
17: ifnull        23
20: goto          33
23: new           #129                // class ghc_prim/ghc/types/datacons/ZMZN
26: dup
27: invokespecial #131                // Method ghc_prim/ghc/types/datacons/ZMZN."<init>":()V
30: putstatic     #127                // Field DZMZN:Leta/runtime/stg/Closure;
33: aload_0
34: monitorexit
35: getstatic     #127                // Field DZMZN:Leta/runtime/stg/Closure;
38: areturn

```


## C imports

GHC supports native(C language) calls. (for instance used in Base packages)


Eta rewrites those parts to use jvm calls.

original GHC `Float.hs` fragment

```
foreign import ccall unsafe "isFloatNaN" isFloatNaN :: Float -> Int
foreign import ccall unsafe "isFloatInfinite" isFloatInfinite :: Float -> Int
foreign import ccall unsafe "isFloatDenormalized" isFloatDenormalized :: Float -> Int
foreign import ccall unsafe "isFloatNegativeZero" isFloatNegativeZero :: Float -> Int
foreign import ccall unsafe "isFloatFinite" isFloatFinite :: Float -> Int
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
foreign import java unsafe "@static eta.base.Utils.isFloatFinite"
  isFloatFinite :: Float -> Bool

```

## Etlas

Haskell GHC developers use cabal (or stack).

Etlas is eta tool  which is ~ cabal. It uses .cabal file format with extensions. 


## Hackage


Tons of libraries for haskell.

De facto standard.


```
Categories:  (3), - (1), .NET (9), Accessibility (3), ACME (49), Adjunctions (1), ADSB (4), 
AI (51), Algebra (35), Algorithm (3), Algorithm Visualization (1), Algorithms (116), 
Anatomy (1), Animation (6), AOP (2), API (26), Apple (3), Application (25), Application Server (2),
 Applicative (1), Argumentation (4), Arrows (5), Artificial Intelligence (2), Arxiv (1), ASP (1), 
 Aspect Oriented Programming (2), AST (1), Atom (1), ATS (8), Attoparsec (2), Attribute Grammars (1), 
 Audio (13), Authentication (9), Automation (2), Avers (4), Aviation (19), AWS (136), Backup (2), Base (1), 
 Benchmarking (11), Big Data (2), Binary (1), Bindings (39), Bio (4), Bioinformatics (99), Bit (2), Bit Vectors (7),
  Bitcoin (12), Blockchain (1), Browser (7), BSD (1), Bsd3 (1), Bsparse (1), Build (6), Build Tool (1), 
  Builders (1), Business (3), ByteString (3), ByteStrings (1), C (1), Cabal (1), Cache (2), Caching (1), CAPTCHA (1), Cast (1), Categories (7), Category (1), CGI (1), Charts (4), Chat (1), Chemistry (5), CI (1), Classification (4), Clckwrks (11), CLI (19), CLI Tool (1), Client (5), Cloud (246), Cloud Haskell (5), CLR (6), Clustering (7), Code Competitions (1), Code Generation (24), Codec (131), Codecs (8), Combinatorics (1), Combinators (17), Command Line (4), Command Line Tool (4), Command Line Tools (1), CommandLine (1), Commerce (1), Commercial (2), Common-Parts (1), Comonads (16), Compatibility (7), Compilation (1), Compiler (50), Compiler Plugin (7), Compilers (3), Compilers/Interpreters (133), Composition (10), Compression (12), Computer Algebra (1), Concurrency (194), Concurrent (11), Conduit (66), Config (2), Configuration (30), Console (82), Constraint (1), Constraints (13), Containers (3), Contract (1), Contracts (1), Control (643), Control.Parallel.Eden (1), Convenience (1), Conversion (5), CouchDB (1), CPP (1), Criu (2), Crosswords (1), Crypto (22), Cryptocurrency (1), Cryptography (124), CsSyd (1), CSV (10), Culinary (1), Data (1656), Data Conduit (1), Data Flow (1), Data Mining (19), Data Science (2), Data Structure (2), Data Structures (217), Data-structures (1), Database (380), Database Design (1), Database Testing Web (3), Databases (3), Datamining (3), Date (2), Debian (4), Debug (39), Debugging (3), Decompiler (1), Deep Learning (1), Demo (7), Dependency Injection (1), Dependent Types (31), Derive-monoid (1), Desktop (17), Desktop Environment (4), Development (619), Diagnostics (1), Diagram (1), Digest (2), Disassembler (3), Distributed Computing (159), Distributed Systems (1), Distribution (120), DNS (1), Documentation (21), Download Manager (2), DSL (3), EBNF (1), Eden (3), Editing (1), Editor (20), Education (28), Educational (2), Effect (12), Emacs (1), Email (9), Embedded (26), Enumerator (29), Environment (1), Error Handling (22), Ethereum (5), Eval.so (1), Eventloop (1), Eventsourcing (11), Example (1), Exception (1), Exceptions (6), Executable (1), Experiment (1), Experimental (2), Extension (10), Factual (2), Failure (25), Fay (9), Fedora (3), Feed (1), FFI (110), FFI Tools (8), File (5), File Manager (3), Filesystem (17), Finance (54), Finance Network Bitcoin (1), Financial (2), Fitness (1), Font (2), Foreign (77), Foreign Binding (5), Formal Languages (9), Formal Methods (30), Foundation (2), Fractals (1), Framework (2), FRP (72), Functions (5), Functors (6), Game (229), Game Engine (30), Games (2), Genealogy (2), General (1), Generic (5), Generics (93), Gentoo (1), Geo (2), Geography (9), Geometry (11), Geospatial (1), GHC (22), GIS Programs (1), Git (7), GitHub (3), GiveYouAHead (2), Google (110), GPU (2), Graph (2), Graphics (521), Graphs (30), Groundhog (1), GUI (62), Hakyll (1), HAM (1), Ham-radio (1), Happstack (17), Hardware (52), Hash (5), Haskell (7), Haskell2010 (3), Haskell98 (2), Hasql (9), Help (2), Heuristics (2), HTML (11), HTTP (4), Hxt (1), Hydraulics (1), Hydrology (1), I2C (2), IDE (15), Image (12), Image Processing (2), Image Viewer (3), Indexed (1), Interaction (2), Interfaces (8), Interpreter (1), IO (2), IO-Streams (18), IoT (1), IRC (12), IRC Client (2), IRI (1), Iteratee (1), Japanese Natural Language Processing (1), Java (13), JavaScript (19), JSON (65), JSX (1), JVM (14), Kerf (1), Ketchup (1), Keyword Extractor (1), Lalr (1), Lambda Cube (1), LambdaCalculus (2), Language (550), Language Tools (1), Languages (4), LaTeX (6), Lazy (1), Learning Environments (1), Learning Haskell (1), Lens (7), Lenses (32), Lexer (2), Lib (1), Library (14), Linear Algebra (2), Linguistics (5), Linux (2), Linux Desktop (1), List (10), Little Game (1), Local Search (1), Logging (26), Logic (32), Logic Programming (3), Logstash (1), LUA (1), Machine Learning (36), Machine Vision (3), Machines (2), Mail (4), Manatee (17), Map (1), MapReduce (1), Math (506), Mathematics (7), Maths (3), Matrix (1), Media (10), Medical (2), Memoization (1), Memory (1), Message-Oriented (1), Message-Oriented Middleware (5), Meta (1), Metalanguage (1), Metrics (4), Microcontroller (4), Middleware (3), Minecraft (2), Miscellaneous (1), Miso (1), Mobile (5), Model (3), Monad (19), Monadic Regions (12), MonadIO (1), Monads (87), Money (1), Monitoring (8), Multimedia (3), Multimedia Player (2), Mumeric.Statistics (1), Murmur (1), Music (86), MusicBrainz (1), Mutable State (1), NA (1), Naqsha (1), Natural Language (1), Natural Language Processing (85), Net (1), Network (937), Network APIs (14), Network Control (1), NetworkAPI (1), NetworkAPIs (1), Networking (12), Nix (14), NLP (6), Noise (2), None (1), NonEmpty (1), Ntrol (1), Number Theory (12), Numeric (42), Numerical (62), Numerics (2), OAuth (1), Object Storage (1), Ocilib (1), ODPI-C (1), Office (1), OOP (1), OpenLayers (1), Operating System (4), Operations (1), Optimisation (12), Optimization (13), Options (6), Oracle (2), Other (21), OverloadeLabels (1), PagerDuty (1), Parallelism (38), Parry (1), Parser (21), ParserCombinators (2), Parsers (5), Parsing (174), Password (5), Pattern (1), Pattern Classification (2), Pattern Recognition (1), PDF (9), PDF Viewer (1), Performance (3), Persistent (2), PersonalGrowth (1), Phantom Types (5), Phishing (1), Physics (27), Picture (1), Pipes (46), PL/SQL Tools (1), Planning (1), Plotting (1), Plugin (1), Poker (1), Polymorphism (2), PostgreSQL (13), Potoki (1), Prelude (65), Preprocessor (3), Pretty Printer (15), Pretty-printing (1), Process Manager (1), Profiling (14), Program Transformation (2), Project (8), Prompt (1), Protocol (5), Proxies (1), Ptr (1), Pugs (8), Pup-Events (5), PureScript (1), Quantum (2), QuasiQoutes (1), QuasiQuotes (3), QuickCheck (2), Qux (2), Raaz (1), Radio (1), RAKE (1), Random (12), Raspberrypi (3), Raw (1), RDF (1), Reactive (3), Reactivity (28), Records (24), Recursion (3), Refactoring (4), Reflection (9), Regex (6), Relational Algebra (1), Relaxng (1), REPL (1), Reverse Engineering (3), RFC (1), Robotics (7), RSS (2), RSS/Atom Reader (1), Saas (1), Safe (1), Sample Code (1), Scheduling (3), Science (11), Scientific (1), Scientific Simulation (1), Screencast (1), Screensaver (1), Scripting (6), SDR (1), Search (12), Security (27), Selenium (1), Semantic Web (3), Semigroups (1), Serialization (19), Servant (22), Service (3), Services (2), Set Theory (1), Shake (6), Shell (2), Si5351 (1), Silk (1), Silly Tool (1), Simple (4), Simulation (17), SMT (11), Snap (34), Snaplet-fay (1), Socket (1), Software (3), Software Defined Radio (2), Sorting (1), Sound (182), Source Code Analysis (2), Source Tools (1), Source-tools (8), Spreadsheet (1), SQLite (1), Static Analysis (7), Statistical Modeling (1), Statistics (48), Steganography (1), Stemming (1), STM (1), STM32 (4), Stochastic Control (1), Stomp (4), Stratux (4), Streaming (23), String (6), Structures (1), Subversion (1), Support Vector Machine (1), SVD (1), Svg (2), Swagger (3), Symbolic Computation (10), Syntax (6), SyntComp (1), System (635), System Tools (2), Systems (1), Tasty-kat (1), Teaching (7), Template (8), Template Haskell (35), TemplateHaskell (1), Templating (2), Terminal (6), Test (22), Testing (271), Testing-hackage (1), Text (789), Text Editor (1), Text Recognition (1), Text.PrettyPrint (1), TH (2), Theorem Provers (42), Time (34), Time-frequency Distributions (1), Timeout (1), TODO (5), TOML (2), Tools (37), Topology (1), TouchDesigner (1), Trace (12), Training (1), Trans (1), Transformation (3), Translation (1), Tree (4), Tutorials (1), Type Inference (1), Type System (35), Type Theory (1), Typechecking (1), Types (3), Typesystems (1), Typography (6), UI (8), Unicode (3), Unification (2), Uniform (4), Unikernel (1), Unknown (3), Unsafe (2), Ur/Web (2), URI (2), URL (1), User Interface (1), User Interfaces (69), User-interface (2), UserInterface (4), Util (4), Utilities (10), Utility (40), Utils (83), Uzbl (1), Validity (8), Value (4), Vector (5), Video (2), Visual Programming (2), Visualization (1), Wai (2), Water (1), Web (1487), Web Server (1), Web Yesod (1), WebDriver (1), Webframework (1), Welcome (1), Wiki (1), Workflow (1), Wsjtx (1), X11 (1), XFCE (1), XML (103), XMonad (3), Yampa (1), Yesod (96), Yi (18), Zeromq (1), Zift (7), Zippers (2), Unclassified (240).

```


## Eta hackage patches


Project  typelead/hackage ==  patches for common hackage projects.


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


## Supports compile extensions


```haskell
{-# LANGUAGE FlexibleContexts, DataKinds, TypeFamilies, RankNTypes #-}
--  whatever
```


Eta is as close as you can get with Haskell/GHC on JVM


Lots of crazy haskell codes that use GHC extensions work on Eta without any problems.



# Basic optimizations


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


Eta
  
```{haskell}
fibtcoinner 0 sum presum  = sum
fibtcoinner n sum presum = fibtcoinner  (n-1) (sum + presum) sum

fibtco n = fibbtcoinner n 1 0

``` 


First results....


```
[1,1,2,4,8,16,32,64,128,256,512...]
```


## Bug #603

It took couple of nights to fix this bug. I've Learned [haskell](https://github.com/typelead/eta/issues/603)...


![scared](src/images/scared.jpg)


![having a help](src/images/help.png)<!-- .element style="height: 500px" -->

With a help of main Eta developer it was not that hard 
It was fun


Decompiled eta. Fixed.
 
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


## How much Eta stands???


```haskell
main = print $ show $  fibtco 1000000
```


yes 1.000.000


## Trampoline 

```{Haskell}

import Control.Monad.Trans.Cont

fibCps::Int->Cont r Int
fibCps 0 = return 1
fibCps 1 = return 1
fibCps n = do
      n1 <- fibCps $ n-1
      n2 <- fibCps $ n-2
      return $ n1 + n2
      

main = do
        let result = trampoline $ runCont  ( fibCps 100 ) id
        putStrLn $ show result

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


Unfair benchmark - both Frege and Eta were measured with JVM startup time.


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


# Styles of interoperatibiliy


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
- Haskell functions wok on Java objects
- Support and use of Java frameworks, serializations, db bindings, jsons.


Hint: in 2018a most of java frameworks do not need classical/ ugly *JavaBeans* anymore.


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


![snow](src/images/snow.jpeg)

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


Data in haskell, businell logic in haskell. 
Java as Controller.


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


[https://github.com/jarekratajski/eta_life](https://github.com/jarekratajski/eta_life)


## problems

- lot of imports to write for every  simple java class
   - this will be fixed thanks to ffi tool
- it took me a while to find out how to pass state between haskell and java
- other bug found (and resolved)
- java monad / io monad - not totally intuitive (for a newbie) 



## Eta vs Frege


I used Frege very shortly.

- **Frege** is more mature
- Interoperation with Java is easier with Frege
- Frege will not be close to GHC in the near future
   - at the semantics level
   - at the base libraries level



# Eta for you


## Eta now


Eta is 0.8.0b1 is (probably) not of  production quality,  yet


If You think of eta in production soon -> talk to **Typelead**.

They want to provide commercial support - ask them for conditions.  


If you are haskell developer that wants to evaluate haskell on JVM

*Try it now!* It is fun.


 If you are JVM / JavaDeveloper that wants to learn and play with Haskell

*Play now!* 


# Eta community


Small. 


Great!


You can help! There are lot of small things to do.


**Future of eta lies in your hands** 
