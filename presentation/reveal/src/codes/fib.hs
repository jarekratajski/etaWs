fibtcoinner 0 sum presum  = sum
fibtcoinner n sum presum = fibtcoinner  (n-1) (sum + presum) sum

fibtco n = fibtcoinner n 1 0

main = do
  putStrLn $ show $ fibtco 10000