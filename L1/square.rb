print "Введите a: "
  a = gets.chomp.to_i
print "Введите b: "
  b = gets.chomp.to_i
print "Введите c: "
  c = gets.chomp.to_i

D = b * b - 4 * a * c

if (D == 0)
  puts "D: #{D} x: #{-b / (2 * a)}"

elsif (D > 0)
  puts "D: #{D} x1:#{(-b + Math.sqrt(D)) / (2 * a)}
  x2: #{(-b - Math.sqrt(D)) / (2 * a)}"

else
  puts "D: #{D} Корней нет"
end
