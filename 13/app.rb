i = 0
earliest_possible_depart_time = 0
bus_ids = []

File.readlines("input").each do |line|
  earliest_possible_depart_time = line.to_i if i == 0
  bus_ids = line.split(",").delete_if { |e| e == "x" }.map { |e| e = e.to_i } if i == 1
  i += 1
end

all_bus_times = []

bus_ids.each do |bus|
  i = 1
  timetable = []
  loop do
    timetable << bus * i
    break if i > earliest_possible_depart_time
    i += 1
  end

  all_bus_times << {
    bus_id: bus,
    timetable: timetable
  }
end

closest_departures = []

all_bus_times.each do |bus|
  time = bus[:timetable].find { |time| time >= earliest_possible_depart_time }
  closest_departures << {bus_id: bus[:bus_id], time: time} if time != nil
end

closest_bus = closest_departures.min_by { |k| k[:time] }
wait_time = closest_bus[:time] - earliest_possible_depart_time

puts "Answer: #{(wait_time) * closest_bus[:bus_id]} (#{ (wait_time) } mins wait)"