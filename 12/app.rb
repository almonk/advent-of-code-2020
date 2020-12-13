input = File.readlines "input", "\n"
instructions = []

# Compass directions
NORTH = "N"
SOUTH = "S"
EAST = "E"
WEST = "W"

# Relative directions
LEFT = "L"
RIGHT = "R"
FORWARD = "F"

# Starting direction in degrees from NORTH
rotation = 90
position_x = 0
position_y = 0

input.each do |int|
  type = int.split("")

  instructions << {
    type: type[0],
    value: int.strip.split("")[1..].join("").to_i,
  }
end

i = 0
loop do
  break if i >= instructions.length

  int = instructions[i]

  case int[:type]
  when NORTH
    puts "Move NORTH by #{int[:value]}"
    position_y -= int[:value]
  when SOUTH
    puts "Move SOUTH by #{int[:value]}"
    position_y += int[:value]
  when EAST
    puts "Move EAST by #{int[:value]}"
    position_x += int[:value]
  when WEST
    puts "Move WEST by #{int[:value]}"
    position_x -= int[:value]
  when LEFT
    puts "Move LEFT by #{int[:value]}"
    rotation -= int[:value] % 360
  when RIGHT
    puts "Move RIGHT by #{int[:value]}"
    rotation += int[:value] % 360
  when FORWARD
    puts "Move FORWARD by #{int[:value]}"
    if rotation % 360 == 0
      position_y -= int[:value]
    elsif rotation % 360 == 90
      position_x += int[:value]
    elsif rotation % 360 == 180
      position_y += int[:value]
    elsif rotation % 360 == 270
      position_x -= int[:value]
    end
  else
    puts "Instruction!"
    break
  end

  puts "Current: x:#{position_x} y:#{position_y} r:#{rotation % 360}"
  i += 1
end

puts "Facing #{rotation % 360}"
puts "Position x #{position_x}"
puts "Position y #{position_y}"
puts "Answer: #{position_x + position_y}"
