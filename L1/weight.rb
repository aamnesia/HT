print "Введите Ваше имя: "
name = gets.chomp

print "Введите Ваш рост: "
height = gets.chomp.to_i

perfect_weight = (height - 110) * 1.15

unless perfect_weight < 0
  puts "#{name}, Ваш оптимальный вес #{perfect_weight.to_i} кг"
else
  puts "#{name}, Ваш вес уже оптимальный"
end
