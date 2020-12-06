raw_boarding_passes = File.readlines "input.txt", "\n"
@total_rows = 127
@total_cols = 7
@boarding_passes = []

def decode_ticket(ticket_arr)
  previous_row_result = (0..@total_rows).to_a
  previous_col_result = (0..@total_cols).to_a

  ticket_arr.each do |l|
    case l
    when "F"
      previous_row_result =
        previous_row_result[0..previous_row_result.length / 2]
    when "B"
      previous_row_result =
        previous_row_result[previous_row_result.length / 2..previous_row_result.length]
    when "L"
      previous_col_result =
        previous_col_result[0..previous_col_result.length / 2]
    when "R"
      previous_col_result =
        previous_col_result[previous_col_result.length / 2..previous_col_result.length]
    else
    end
  end

  return ticket_hash = {
           row: previous_row_result[0],
           col: previous_col_result[0],
           seat_id: (previous_row_result[0] * 8) + previous_col_result[0],
         }
end

raw_boarding_passes.each do |ticket|
  @boarding_passes << decode_ticket(ticket.split(""))
end

puts @boarding_passes.max_by { |k| k[:seat_id] }

# Part 2
puts "Finding empty seats"

i = 0
for i in 0..@total_rows
  c = i
  matching_rows = @boarding_passes.select { |ticket| ticket[:row] == i }
  for c in 0..@total_cols
    if matching_rows.select { |ticket| ticket[:col] == c }.length == 0
      puts "Empty seat at row #{i} col#{c}"
    end
  end
end
