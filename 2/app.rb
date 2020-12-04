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
    character: character
  }

  passwords << password_hash
end

# Iterate thru each password hash and check rules
passwords.each do |hash|
  character_occurences = hash[:password].count hash[:character]
  if character_occurences >= hash[:min_amount] && character_occurences <= hash[:max_amount]
    valid_passwords << hash
  end
end

puts valid_passwords.length