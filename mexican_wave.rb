def wave(str)
  wave = []
  current_char = 0
  str.delete(' ').length.times do
    str_array = str.downcase.split('')    
    loop do
      unless str_array[current_char] == ' '
        str_array[current_char].upcase!
        break
      end
      current_char += 1
    end
    wave.push(str_array.join(''))
    current_char += 1
  end
  wave
end