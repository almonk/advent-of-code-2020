require "set"

@input = File.readlines "input.txt", "\n"
@instructions = []

# Read input into structure
@input.each do |int|
  int_hash = {
    type: int.split(" ")[0],
    param: int.split(" ")[1],
    has_run: false,
  }

  @instructions << int_hash
end

def compute_param(param, original_value)
  if param.chars.first == "+"
    original_value += param.split("+")[1].to_i
  else
    original_value -= param.split("-")[1].to_i
  end

  return original_value
end

# Walk thru instructions
x = 0
accumulator_val = 0

loop do
  # Check end of input
  if x >= @instructions.length
    break
  end

  # Get instruction
  instruction = @instructions[x]

  # Check instruction has not been run before
  if instruction[:has_run] == true
    puts "Detected infinite loop!"
    break
  end

  # Process instruction
  puts instruction

  case instruction[:type]
  when "nop"
    puts "-- No Operation"
  when "acc"
    puts "-- Accumulator"
    accumulator_val = compute_param(instruction[:param], accumulator_val)
  when "jmp"
    puts "-- Jump to"
    x = compute_param(instruction[:param], x)

    # Skip loop iteration
    next
  else
    puts "Did not understand instruction"
    break
  end

  # Next instruction
  instruction[:has_run] = true
  x += 1
end

puts accumulator_val