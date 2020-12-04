input = "./passwords.txt"

passwords = []
valid_passwords = []

# Read all passwords and get rules
File.open(input, "r").each_line do |line|
  line = line.strip
  min, max, character = line.split(":")[0].match(/(.*)[-](.*).(.)/).captures

  password_hash = {
    password: line.split(": ")[1],
    min_amount: min.to_i,
    max_amount: max.to_i,
    character: character,
  }

  passwords << password_hash
end

# Iterate thru each password hash and check rules
passwords.each do |hash|
  # Check characters at min and max position...
  puts "Letter at #{hash[:password][hash[:min_amount]-1]} and letter at #{hash[:password][hash[:max_amount]-1]} and character to look for #{hash[:character]}"
  if hash[:password][hash[:min_amount]-1] == hash[:character]
    if hash[:password][hash[:max_amount]-1] != hash[:character]
      valid_passwords << hash
      puts "PASS"
    end
  elsif hash[:password][hash[:min_amount]-1] != hash[:character]
    if hash[:password][hash[:max_amount]-1] == hash[:character]
      valid_passwords << hash
      puts "PASS"
    end
  end
end

puts valid_passwords.length
