input = File.readlines "input.txt", "\n"
@input = input.map { |n| n = n.strip.to_i }
@magic_num = 22406676

maximum_contig_set_size = 10

i = 2
while i < 30
  @input.each_cons(i) do |a|
    if a.sum == @magic_num
      puts "Found in couplet: #{a.inspect}"
      puts "Lowest: #{a.min}"
      puts "Max: #{a.max}"
      puts "Sum: #{a.min + a.max}"
      exit
    else
      puts "#{a.inspect} = SUM: #{a.sum}"
    end
  end
  i += 1
end
