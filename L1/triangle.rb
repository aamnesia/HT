print "Введите a: "
  a = gets.chomp.to_i

print "Введите b: "
  b = gets.chomp.to_i

print "Введите c: "
  c = gets.chomp.to_i

if a < b
  a, b = b, a
end

if a < c
  a, c = c, a
end

if a == b && a == c
  puts "Треугольник равносторонний"

elsif a == b || a == c || b == c
  puts "Tреугольник равнобедренный"

elsif b*b + c*c == a*a
  puts "Треугольник прямоугольный"

else
  puts "Треугольник не является прямоугольным, равнобедренным или равносторонним"
end
