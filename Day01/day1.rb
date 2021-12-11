file = File.open("input.txt")
file_data = file.readlines.map(&:chomp)
file_data.map!(&:to_i)

count = 0
(1...file_data.size).each do |index|
  count += 1 if file_data[index] > file_data[index - 1]
end

puts count
