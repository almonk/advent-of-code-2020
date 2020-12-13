input = File.readlines "input-test", "\n"
instructions = []

# Compass directions
NORTH = "N"
SOUTH = "S"
EAST = "E"
WEST = "w"

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
    position_y -= int[:value]
  when SOUTH
    position_y += int[:value]
  when EAST
    position_x += int[:value]
  when WEST
    position_x -= int[:value]
  when LEFT
    rotation -= int[:value]
  when RIGHT
    rotation += int[:value]
  when FORWARD
    if rotation == 0
      position_y -= int[:value]
    elsif rotation == 90
      position_x += int[:value]
    elsif rotation == 180
      position_y += int[:value]
    elsif rotation == 270
      position_x -= int[:value]
    end
  else
  end

  i += 1
end

puts "Facing #{rotation}"
puts "Position x #{position_x}"
puts "Position y #{position_y}"
puts "Answer: #{position_x + position_y}"
