require "set"

groups = File.readlines "input.txt", "\n\n"
running_count = 0

groups.each do |group|
  people = group.split "\n"
  group_answers = []
  
  people.each do |person|
    indivual_answers = person.split ""
    group_answers << indivual_answers
  end

  group_answers = Set.new group_answers.flatten
  running_count += group_answers.length
end

puts "Total questions answered: #{running_count}"
