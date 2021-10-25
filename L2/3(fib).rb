fib = [0, 1]
10.times do |i|
  fib[i + 2] = fib[i + 1] + fib[i]
end
print fib
