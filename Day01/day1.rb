# frozen_string_literal: true

def part1(data)
  count = 0
  (1...data.size).each do |index|
    count += 1 if data[index] > data[index - 1]
  end

  puts count
end

def part2(data)
  windows = []
  (0...data.size - 2).each do |_index|
    windows.push(data[_index] + data[_index + 1] + data[_index + 2])
  end
  part1(windows)
end

file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)
file_data.map!(&:to_i)

part2(file_data)
