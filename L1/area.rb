print "Введите основание: "
  a = gets.chomp.to_i

print "Введите высоту: "
  h = gets.chomp.to_i

area = 0.5 * a * h

puts "Площадь треугольника: #{area.to_i}"
