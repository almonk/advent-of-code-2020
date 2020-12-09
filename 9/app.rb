input = File.readlines "input.txt", "\n"
@input = input.map { |n| n = n.strip.to_i }

def is_valid?(number, at_index)
  all_sums = []
  preamble = @input[at_index - 26..at_index]

  preamble.each do |p|
    i = 0
    for i in 0..preamble.length - 1
      all_sums << p + preamble[i] unless preamble[i] == p
      i += 1
    end
  end

  return true if all_sums.include?(number)
  return false
end

def scan_input
  index = 26
  sliced_input = @input[25..]
  sliced_input.each do |n|
    puts "#{n}: #{is_valid?(n, index)}"
    
    break if !is_valid?(n, index)
    index += 1 if is_valid?(n, index)
  end
end

scan_input
