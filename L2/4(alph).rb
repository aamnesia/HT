alph = Hash[(:a..:z).to_a.zip((1..26).to_a)]
alph.each do |let, num|
  unless ["a", "i", "e", "o", "u", "y"].include? (let.to_s)
    alph.delete(let)
  else
    puts "#{let} - #{num}"
  end
end
