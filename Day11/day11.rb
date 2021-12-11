# frozen_string_literal: true

def explode(i, j)
  @exploded[i][j] = true
  @matrix[i][j] = 0

  [-1, 0, 1].each do |x|
    [-1, 0, 1].each do |y|
      next unless in_bounds?(i + x, j + y)

      add_energy(i + x, j + y)
    end
  end
end

def add_energy(i, j)
  return if @exploded[i][j]

  @matrix[i][j] += 1
  explode(i, j) if @matrix[i][j] == 10
end

def in_bounds?(i, j)
  true if i >= 0 && j >= 0 && i < @matrix.length && j < @matrix[0].length
end

def part2
  time = 0
  loop do
    @count = 0
    time += 1
    flash

    break if @count == @matrix.length * @matrix[0].length
  end

  puts time
end

def part1
  @count = 0
  100.times do
    flash
  end

  puts @count
end

def flash
  @matrix.each_with_index do |x, i|
    x.each_with_index do |_item, j|
      add_energy(i, j)
    end
  end
  @exploded.each { |line| @count += line.count(true) }
  @exploded = Array.new(@matrix.length) { Array.new(@matrix[0].length, false) }
end

file = File.open('input.txt')
file_data = file.readlines(&:chomp)
file_data.map! { |line| line.strip.split('') }
@matrix = file_data.map { |line| line.map!(&:to_i) }

@exploded = Array.new(@matrix.length) { Array.new(@matrix[0].length, false) }

#part1
part2
puts @matrix.map { |x| x.join(' ') }
