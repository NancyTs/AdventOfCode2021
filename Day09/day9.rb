# frozen_string_literal: true

# puts File.open("main.rb").readlines.join("--")

def visit(i, j)
  return if @visited[i][j]

  @visited[i][j] = true
  found = false
  iterate = [[0, 1], [1, 0], [0, -1], [-1, 0]]

  iterate.each do |coords|
    next unless inBounds?(i + coords[0], j + coords[1])

    if @matrix[i][j] >= @matrix[i + coords[0]][j + coords[1]]
      found = true
      visit(i + coords[0], j + coords[1])
    end
  end

  @locations.push([i, j]) unless found
  @smallest.push(@matrix[i][j]) unless found
end

def expand_basin(i, j)
  return if @visited[i][j]

  @visited[i][j] = true
  return if @matrix[i][j] == 9

  iterate = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  @size += 1

  iterate.each do |coords|
    next unless inBounds?(i + coords[0], j + coords[1])

    if @matrix[i][j] < @matrix[i + coords[0]][j + coords[1]] && @matrix[i + coords[0]][j + coords[1]] < 9
      expand_basin(i + coords[0], j + coords[1])
    end
  end
end

def inBounds?(i, j)
  true if i >= 0 && j >= 0 && i < @matrix.length && j < @matrix[0].length
end

file = File.open('Day09/input.txt')
file_data = file.readlines(&:chomp)
file_data.map! { |line| line.strip.split('') }
@matrix = file_data.map { |line| line.map!(&:to_i) }

@visited = Array.new(@matrix.length) { Array.new(@matrix[0].length, false) }
@smallest = []
@locations = []
@basins = []

@matrix.each_with_index do |x, i|
  x.each_with_index do |_item, j|
    visit(i, j)
  end
end

@visited = Array.new(@matrix.length) { Array.new(@matrix[0].length, false) }
@locations.each do |coords|
  @size = 0
  expand_basin(coords[0], coords[1])
  @basins.push(@size)
end

@basins.sort!.reverse!
puts @basins[0] * @basins[1] * @basins[2]
