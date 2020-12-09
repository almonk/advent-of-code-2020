input = File.readlines "input.txt", "\n"
input = input.map { |n| n = n.strip.to_i }
magic_num = 22406676
maximum_contig_set_size = 30

i = 2
while i < maximum_contig_set_size
  input.each_cons(i) do |a|
    puts "Answer: #{a.min + a.max}" if a.sum == magic_num
  end

  i += 1
end
