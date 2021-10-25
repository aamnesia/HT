puts "Число: "
day = gets.chomp.to_i
puts "Месяц: "
month = gets.chomp.to_i
puts "Год: "
year = gets.chomp.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  days_in_month[1] = 29
end

number = 0
i = 0
while i < month - 1 do
  number += days_in_month[i]
  i += 1
end
number += day
print number
