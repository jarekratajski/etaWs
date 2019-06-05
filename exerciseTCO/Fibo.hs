
fibnaive  0 = 1
fibnaive  1 = 1
fibnaive  n = fibnaive ( n-1) + fibnaive ( n - 2)


fibtcoinner 0 sum presum  = sum
fibtcoinner n sum presum = fibtcoinner  (n-1) (sum + presum) sum

fibtco n = fibtcoinner n 1 0


main =  putStrLn $ show $ fibnaive 200
-- main =  putStrLn $ show $ fibtco 20000