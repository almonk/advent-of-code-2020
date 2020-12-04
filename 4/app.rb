passports = File.readlines "input.txt", "\n\n"
required_fields = [
  "byr",
  "iyr",
  "eyr",
  "hgt",
  "hcl",
  "ecl",
  "pid",
]

valid_passports = 0

def hex?(num)
  hex = true
  num.chars.each do |digit|
    hex = false unless digit.match(/\h/)
  end
  hex
end

def validate_passport(passport)
  valid_ecl = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  valid_passes = 0

  kv_pairs = passport.split(" ")
  passport = kv_pairs.map { |i| i.split ":" }.to_h

  valid_passes += 1 if valid_ecl.include?(passport["ecl"])

  valid_passes += 1 if passport["byr"].to_i >= 1920 && passport["byr"].to_i <= 2002

  valid_passes += 1 if passport["iyr"].to_i >= 2010 && passport["iyr"].to_i <= 2020

  valid_passes += 1 if passport["eyr"].to_i >= 2020 && passport["eyr"].to_i <= 2030

  valid_passes += 1 if passport["pid"].length == 9

  if passport["hcl"].length == 7
    if passport["hcl"].chars.first == "#"
      hcl_minus_hex = passport["hcl"][1..-1]
      if hex?(hcl_minus_hex)
        valid_passes += 1
      end
    end
  end

  if passport["hgt"].split(//).last(2).join == "cm"
    formatted_hgt = passport["hgt"].delete_suffix("cm")
    if formatted_hgt.to_i >= 150 && formatted_hgt.to_i <= 193
      valid_passes += 1
    end
  end

  if passport["hgt"].split(//).last(2).join == "in"
    formatted_hgt = passport["hgt"].delete_suffix("in")
    if formatted_hgt.to_i >= 59 && formatted_hgt.to_i <= 76
      valid_passes += 1
    end
  end

  if valid_passes == 7
    return true
  else
    return false
  end
end

passports.each do |passport|
  # Split into an array of k/v pairs
  kv_pairs = passport.split(" ")

  # Discover the key names
  present_keys = []
  kv_pairs.each do |pair|
    key = pair.split(":")[0]
    present_keys << key
  end

  difference = required_fields - present_keys

  if difference.length == 0
    # Has all valid keys
    if validate_passport(passport)
      valid_passports += 1
    end
  else
    # Has some missing keys
  end
end

puts valid_passports
