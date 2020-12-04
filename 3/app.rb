input = "./map.txt"

map_rows = []
tree = "#"
empty = "."
x_position_on_slope = 1
tree_counter = 0

# Read map in to memory
File.open(input, "r").each_line { |line| map_rows << line }

# Get size of our map
map_width = map_rows[0].length
map_height = map_rows.length

i = 0

for i in map_rows do
  next_coordinate = map_rows[i].split("")
  position = next_coordinate[x_position_on_slope]

  if position == tree
    tree_counter += 1
  end
  

  if x_position_on_slope > map_width -2
    x_position_on_slope = 0
  else
    x_position_on_slope += 3
  end
end

puts tree_counter