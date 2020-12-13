@input = File.readlines "input-test.txt", "\n"
@instructions = []

# Read input into structure
i = 0
@input.each do |int|
  int_hash = {
    type: int.split(" ")[0],
    param: int.split(" ")[1],
    has_run: false,
    index: i,
  }

  @instructions << int_hash
  i += 1
end

def compute_param(param, original_value)
  original_value += param.to_i
  return original_value
end

def start_vm(instructions:)
  # Walk thru instructions
  x = 0
  accumulator_val = 0
  loop do
    # Check end of input
    if x >= instructions.length
      break
    end

    # Get instruction
    instruction = instructions[x]

    # Check instruction has not been run before
    if instruction[:has_run] == true
      puts "Detected infinite loop!"
      break
    end

    # Process instruction
    puts "LINE #{x + 1}  \t: #{instruction.to_s}     \t\t#{accumulator_val}"

    case instruction[:type]
    when "nop"
    when "acc"
      accumulator_val = compute_param(instruction[:param], accumulator_val)
    when "jmp"
      x = compute_param(instruction[:param], x)
      next # Skip loop iteration
    else
      puts "Did not understand instruction"
      break
    end

    # Next instruction
    instruction[:has_run] = true
    x += 1
  end
  puts accumulator_val
end

def mutate_instructions(instructions:)
  # Find all nops
  # Find all jmps
  # For each find, switch – run the new instruction
  # Continue until program terminates successfully
  lines_to_mutate = []
  lines_to_mutate << instructions.select { |int| int[:type] == "nop" }
  lines_to_mutate << instructions.select { |int| int[:type] == "jmp" }
  lines_to_mutate = lines_to_mutate.flatten

  i = 0
  while i <= lines_to_mutate.length - 1
    # Create copy of original instructions
    copy_of_instructions = []
    instructions.map { |int| copy_of_instructions << int }

    # Find which element we want to mutate
    instruction_to_mutate = lines_to_mutate[i]
    puts "Mutating line:"
    puts instruction_to_mutate

    puts "to..."
    if instruction_to_mutate[:type] == "nop"
      instruction_to_mutate[:type] = "jmp"
    else
      instruction_to_mutate[:type] = "nop"
    end

    puts instruction_to_mutate
    copy_of_instructions[instruction_to_mutate[:index]] = instruction_to_mutate

    puts "Running iteration #{i}"
    puts copy_of_instructions
    
    i += 1
  end
end

start_vm(instructions: @instructions)
# mutate_instructions(instructions: @instructions)
