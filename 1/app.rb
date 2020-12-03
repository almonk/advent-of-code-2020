input = "./input.txt"
key = 2020
pieces = []

File.open(input, "r").each_line do |line|
  pieces << line.to_i
end

pieces.each do |piece|
  pieces.each do |other_piece|
    puts "#{piece} + #{other_piece} == #{piece + other_piece}" if piece + other_piece == key
  end
end