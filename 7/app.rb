require "set"

@policies = File.readlines "input.txt", "\n"
@bags = []

def find_bags_to_hold(bag_name)
puts "Directly holds #{bag_name}:"
  match = /(?<name>.*?) contain.* (?<holds_gold_bags_amount>\d) #{bag_name}./
  
  @policies.each do |policy|
    if policy.strip.match?(match)
      m = policy.strip.match(match)

      bag_hash = {
        name: m[:name],
        "holds": m[:holds_gold_bags_amount],
      }

      @bags << bag_hash
    end
  end

  @bags = @bags.uniq { |e| e[:name] }
  puts @bags
end

find_bags_to_hold("shiny gold bag")

# Arbitary nested amount guess
5.times do 
  @bags.each do |bag|
    puts "Holds #{bag[:name]}"
    find_bags_to_hold(bag[:name])
  end
end

puts @bags.count