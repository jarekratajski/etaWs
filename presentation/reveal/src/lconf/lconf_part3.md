# Eta compiler



### Optional

Read how to and build eta from sources

https://eta-lang.org/docs/user-guides/eta-user-guide/installation/source

`git clone --recursive --depth 1 https://github.com/typelead/eta`




## Compilation stages



![ghc](src/images/ghcstages.png)<!--.element height="600"-->



## STG

The Spineless Tagless G-machine is an abstract machine designed to support nonstrict higher-order functional languages. 

(from *Iplementing lazy functional languages on stock hardware*:
      the Spineless Tagless G-machine Simon L Peyton Jones )



```stg
Main.main_fibnaive [Occ=LoopBreaker]
  :: GHC.Integer.Type.Integer -> GHC.Integer.Type.Integer
[GblId, Arity=1, Caf=NoCafRefs, Str=<S,U>, Unf=OtherCon []] =
    \r srt:SRT:[] [ds_s7GL]
        case GHC.Integer.Type.eqInteger# ds_s7GL lvl_r7CB of _ [Occ=Dead] {
          __DEFAULT ->
              case
                  GHC.Integer.Type.eqInteger# ds_s7GL lvl1_r7CC
              of
              _ [Occ=Dead]
              { __DEFAULT ->
                    case GHC.Integer.Type.minusInteger ds_s7GL lvl2_r7CD of sat_s7GQ {
                      __DEFAULT ->
                          case Main.main_fibnaive sat_s7GQ of sat_s7GR {
                            __DEFAULT ->
                                case GHC.Integer.Type.minusInteger ds_s7GL lvl1_r7CC of sat_s7GO {
                                  __DEFAULT ->
                                      case Main.main_fibnaive sat_s7GO of sat_s7GP {
                                        __DEFAULT -> GHC.Integer.Type.plusInteger sat_s7GP sat_s7GR;
                                      };
                                };
                          };
                    };
                1 -> lvl1_r7CC;
              };
          1 -> lvl1_r7CC;
        };
```



## Closure

Expression / function

eta -> rts/src/main/java/eta/runtime/stg/Closure.java



## Thunk

Lazy expression
eta -> rts/src/main/java/eta/runtime/Thunk/Thunk.java



# Example problem

Null handling (java <-> eta)

https://github.com/typelead/eta/issues/954



## see exerciseNull



## Tools



## Javap

Disassemble class

`javap -c -p my/HTest.class  >my/res.txt`



## dumping stg and classgeneration

from old doc 

`https://github.com/typelead/eta/blob/0.7.2b1/docs/source/eta-user-guide.rst`

`-ddump-stg -ddump-to-file -ddump-cg-trace`



## interesting places

[Opcodes](https://github.com/rahulmutt/codec-jvm/blob/33c6b01b9bf463635b2ecbbd11e4e8dbdc4c53fc/src/Codec/JVM/Opcode.hs)

[Code](https://github.com/rahulmutt/codec-jvm/blob/33c6b01b9bf463635b2ecbbd11e4e8dbdc4c53fc/src/Codec/JVM/ASM/Code.hs)

[CodeGen](https://github.com/typelead/eta/blob/master/compiler/Eta/CodeGen/Closure.hs)

[Desugar Foreign](https://github.com/typelead/eta/blob/master/compiler/Eta/DeSugar/DsForeign.hs)



Use eta gitter

https://gitter.im/typelead/eta



Current state of eta



- looks stable

- growing tooling

- lots of smaller issues that can be done to make it better



# Want eta on production?

Ask Typelead



Want to play, have fun - do it now



This is one of the few projects where You can easily enter 
and contribute something meaningful 



Even if you learn haskell



# End

`@jarek000000`

`jratajski@gmail.com`