basket = Hash.new
loop do
  print "Товар: "
  name = gets.chomp
  if name == "Стоп"
    break
  end
  print "Цена: "
  cost = gets.chomp.to_i
  print "Количество: "
  number = gets.chomp.to_f

  basket[name] = { cost => number }
end

total = 0 #сумма всех покупок
price = 0 #цена отдельного товара
basket.each do |b, c_n|
  c_n.each do |c, n|
  puts "Товар: #{b} Цена: #{c} Кол-во: #{n}"
  price = c * n
  total += price
  puts "Итоговая сумма за #{b}: #{price}"
  end
end

puts "Итоговая сумма всех покупок: #{total}"
