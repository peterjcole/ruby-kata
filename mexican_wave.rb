def wave(str)
  wave = []
  str.delete(' ').length.times do |i|
    str_array = str.downcase.split('')    
    loop do
      unless str_array[i] == ' ' then
        str_array[i].upcase!
        break
      end
      i += 1
    end
    wave.push(str_array.join(''))
  end
  wave
end

puts wave('hello')


