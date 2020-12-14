input = File.readlines "input", "\n"

instructions = []
registry = [] # Virtual memory registry

input.each do |line|
  match = /^(?<operator>.*?)(\[(?<register>.*?)\]?)? = (?<value>.*?)$/
  m = line.strip.match(match)
  instructions << {
    operator: m[:operator],
    register: m[:register],
    value: m[:value],
  }
end

current_mask = nil

instructions.each_with_index do |int,line|
  case int[:operator]
  when "mask"
    current_mask = int[:value]
  when "mem"
    # Convert number to binary with leading zeroes and turn into an array
    binary_representation = int[:value].to_i.to_s(2).rjust(36,"0").split("")

    # Bit by bit compare against mask
    current_mask.split("").map.with_index do |bit,index|
      next if bit == "X" # Skip X bits
      binary_representation[index] = bit
    end

    new_value = binary_representation.join("").to_i(2)

    if registry.any? {|h| h.has_key? int[:register] }
      # Override the memory value
      hash = registry.find { |h| h.has_key? int[:register] }
      hash[int[:register]] = new_value
    else
      # Push to the registry
      registry << {
        int[:register] => new_value,
      }
    end
  else
    puts "Bad instruction"
  end
end

puts "Dump of memory:"

puts registry.inspect

puts "Sum of all memory value"

total_sum = 0
registry.each do |k|
  total_sum += k.values[0]
end

puts total_sum