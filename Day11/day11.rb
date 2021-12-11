# frozen_string_literal: true

def explode(i, j)
  @exploded[i][j] = true
  iterate = [[-1, -1], [0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [1, -1]]
  iterate.each do |coords|
    next unless inBounds?(i + coords[0], j + coords[1])

    add_energy(i + coords[0], j + coords[1])
  end
end

def add_energy(i, j)
  return if @exploded[i][j]

  @matrix[i][j] += 1
  if @matrix[i][j] == 10
    @matrix[i][j] = 0
    explode(i, j)
  end
end

def inBounds?(i, j)
  true if i >= 0 && j >= 0 && i < @matrix.length && j < @matrix[0].length
end


def part2
  time = 0
  loop do
    count = 0

    @matrix.each_with_index do |x, i|
      x.each_with_index do |_item, j|
        add_energy(i, j)
      end
    end
    time += 1
    @exploded.each { |line| count+=line.count(true)}
    @exploded = Array.new(@matrix.length) { Array.new(@matrix[0].length, false) }

    if count == @matrix.length * @matrix[0].length
      puts time
      return
    end

  end
  puts time
end

def part1
  count = 0
  100.times do
    @matrix.each_with_index do |x, i|
      x.each_with_index do |_item, j|
        add_energy(i, j)
      end
    end
    @exploded.each { |line| count+=line.count(true)}
    @exploded = Array.new(@matrix.length) { Array.new(@matrix[0].length, false) }
  end

  puts count
end


file = File.open('input.txt')
file_data = file.readlines(&:chomp)
file_data.map! { |line| line.strip.split('') }
@matrix = file_data.map { |line| line.map!(&:to_i) }

@exploded = Array.new(@matrix.length) { Array.new(@matrix[0].length, false) }

#part1
part2
puts @matrix.map { |x| x.join(' ') }
