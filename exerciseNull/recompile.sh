#!/bin/bash
rm *.jar
eta -ddump-stg -ddump-cg-trace -ddump-to-file Null.hs
jar xf RunNull.jar my/HTest.class
javap -c -p my/HTest.class  >my/res.txt