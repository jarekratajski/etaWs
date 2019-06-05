# JVM

OMG  - what is a JVM anyway?



A thing that runs `.class` files.



## .class format
```
ClassFile {
    u4             magic;
    u2             minor_version;
    u2             major_version;
    u2             constant_pool_count;
    cp_info        constant_pool[constant_pool_count-1];
    u2             access_flags;
    u2             this_class;
    u2             super_class;
    u2             interfaces_count;
    u2             interfaces[interfaces_count];
    u2             fields_count;
    field_info     fields[fields_count];
    u2             methods_count;
    method_info    methods[methods_count];
    u2             attributes_count;
    attribute_info attributes[attributes_count];
}
```



```java
method_info {
    u2             access_flags;
    u2             name_index;
    u2             descriptor_index;
    u2             attributes_count;
    attribute_info attributes[attributes_count];
}
```

```
Code_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 max_stack;
    u2 max_locals;
    u4 code_length;
    u1 code[code_length];
    u2 exception_table_length;
    {   u2 start_pc;
        u2 end_pc;
        u2 handler_pc;
        u2 catch_type;
    } exception_table[exception_table_length];
    u2 attributes_count;
    attribute_info attributes[attributes_count];
}
```



## opcodes

|instuction| code(hex_)| stack (before -> after) | info|
|--|--|--|--|
|aaload	|32	|	arrayref, index → value	| load onto the stack a reference from an array|
|aconst_null|	01|→ null|	push a null reference onto the stack|
|d2f|	90|	value → result	| convert a double to a float|
|dstore|	39	|  index	value →	|store a double value into a local variable #index|
|dup|	5 |	value → value, value	 | duplicate the value on top of the stack|
<!-- .element style="font-size: 0.6em"-->



## bytecode

- assembly like
- stack based



## "Interpreting" bytecode

Isn't it very slow ? 



Disclaimer: There ar various JVM implementations from multiple vendors.
In the next part I will describe mostly Oracle JVM/OpenJDK.



# JIT compiler

Compile as you go



## Hotspot

interpreter

c1,

c2,

Uses registers (SSE etc.)



## print compilation

Run eta-life with:
`-XX:+PrintCompilation`

See:
[print compilation explained](https://blog.joda.org/2011/08/printcompilation-jvm-flag.html)



## Optimizations

[Hotspot optimization](https://wiki.openjdk.java.net/display/HotSpot/PerformanceTechniques)



C++   developers have to use 
`virtual`, `inline` keywords



Java - virtual(`*`) methods can be inlined...



## inlining
   `-XX:+UnlockDiagnosticVMOptions`
   `-XX:+PrintInlining`



## JitWatch

https://github.com/AdoptOpenJDK/jitwatch



PrintAssembly is cool but practically useless



## escape analysis

```
public int doIt() {
  MyObject o = new MyObject(x);
  return o.x;
}

static class MyObject {
  final int x;
  public MyObject(int x) {
    this.x = x;
  }
}
```

Notice: MyObject in fact is not needed.



It is very hard to make sensible JVM benchmarks



Initially JVM is very slow, 
Then it is sometimes faster than code produced by static compilers (depends).
Sometimes `absurdly` faster (`dead code` elimination).

[Benchmark pitfalls](https://www.oracle.com/technetwork/articles/java/architect-benchmarking-2266277.html)



## JMH

`./gradlew :javaCode:jmh`



## CPU Cache

![CPU Caches](src/images/cpu_cache.png)




![Latencies](src/images/latencies.png)




## Performance counters



`profilers = ['perf']` in jmh section



<pre>
Perf stats:
      15368.100774      task-clock (msec)         #    0.652 CPUs utilized          
              2274      context-switches          #    0.148 K/sec                  
               339      cpu-migrations            #    0.022 K/sec                  
            430539      page-faults               #    0.028 M/sec                  
       39846161097      cycles                    #    2.593 GHz                      (45.39%)
   not supported      stalled-cycles-frontend  
   not supported      stalled-cycles-backend   
                 0      instructions              #    0.00  insns per cycle          (54.51%)
        8485276826      branches                  #  552.136 M/sec                    (54.58%)
         168596195      branch-misses             #    1.99% of all branches          (54.98%)
       16071429355      L1-dcache-loads           # 1045.765 M/sec                    (55.00%)
         504412421      L1-dcache-load-misses     #    3.14% of all L1-dcache hits    (55.12%)
   not supported      LLC-loads                
   not supported      LLC-load-misses          
   not supported      L1-icache-loads          
          42046521      L1-icache-load-misses     #    2.736 M/sec                    (36.62%)
       15030230305      dTLB-loads                #  978.015 M/sec                    (39.27%)
           8339459      dTLB-load-misses          #    0.06% of all dTLB cache hits   (39.33%)
           3322151      iTLB-loads                #    0.216 M/sec                    (39.16%)
           2233477      iTLB-load-misses          #   67.23% of all iTLB cache hits   (38.90%)
   not supported      L1-dcache-prefetches     
   not supported      L1-dcache-prefetch-misses

    23.581580435 seconds time elapsed
</pre>
<!-- .element style="font-size: 0.4em"-->



## Profiling



use `jvisualvm` to connect to running process 




Sampling CPU
vs 
Profiling CPU



Do profiling of `eta-life`


Use `-ddump-stg` switch to get some hints about haskell to java classes/methods mapping.



# Eta

Eta provides own optimizations on top of JVM.




## Naive fibonacci 


```
fibnaive  0 = 1
fibnaive  1 = 1
fibnaive  n = fibnaive ( n-1) + fibnaive ( n - 2)

main =  putStrLn $ show $ fibnaive 200
```

`eta Fibo.hs`


`java -Xss512k -jar RunFibo.jar`



## Better fibonacci

```haskell
fibtcoinner 0 sum presum  = sum
fibtcoinner n sum presum = fibtcoinner  (n-1) (sum + presum) sum

fibtco n = fibtcoinner n 1 0


main =  putStrLn $ show $ fibtco 20000

```

`eta Fibo.hs`

`java -Xss512k -jar RunFibo.jar`



JVM does not support TCO yet



But neither does intel core or any other typical native platform



## Let's try again

Remove all jars

`eta -O2 Fibo.hs`

`java -Xss512k -jar RunFibo.jar`



## Garbage collectors JVM



Concept of mark and sweep collector



Various garbage collectors in  JVMs
- Serial
- Parallel
- CMS
- G1GC
- Shenondoah
- ZGC
- Epsilon


Short pauses vs long  pauses (better throughput)
Small heap  vs large heap
Gnerational vs not generational




