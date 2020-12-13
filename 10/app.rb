# Read every line of the input into an array
bag = File.readlines "input-test", "\n"

# Turn the array of strings into a numerical one and sort them
bag.map! { |n| n = n.to_i }.sort!

# Enrich the array with info of whether we've used this adapter already or not
@adapters = []

# Keep track of difference
@difference = []

bag.each do |n|
  @adapters << {
    rating: n,
    has_been_used: false,
  }
end

# Function to find suitable adapters for a given joltage
def find_suitable_adapter_for(joltage)
  # Create a range of suitable adapters that would work
  suitable_range = (joltage..joltage + 3).to_a

  # Look in the bag for adapters we have and see if any of them match our suitable range
  suitable_range.each do |searching_joltage|
    suitable_adapter = @adapters.find { |n| n[:rating] == searching_joltage && !n[:has_been_used] }

    if suitable_adapter
      # Find difference between joltage and suitable adapter
      joltage_difference = suitable_adapter[:rating] - joltage

      # We've used this now...
      suitable_adapter[:has_been_used] = true

      puts suitable_adapter
      # Keep track of difference
      @difference << joltage_difference
      return suitable_adapter[:rating]
    else
      next
    end
  end
end

i = 0
next_jolt = 0

# Start looping through our bag
loop do
  next_jolt = find_suitable_adapter_for(next_jolt)
  i += 1

  if i > @adapters.length
    # Finally add the device adapter when we reach the end of our adapters
    device_rating = next_jolt[0] + 3
    @difference << device_rating - next_jolt[0]
    break
  end
end

# Find the total difference counts
puts @difference.tally