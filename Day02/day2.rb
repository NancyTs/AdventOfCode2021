def part1(data)
  data.each do |line|
    command = line.split(' ')
    direction = command[0]
    value = command[1].to_i
    case direction
    when 'forward'
      @x += value
    when 'down'
      @y += value
    when 'up'
      @y -= value
    end
  end
  puts @x * @y
end

def part2(data)
  data.each do |line|
    command = line.split(' ')
    direction = command[0]
    value = command[1].to_i
    case direction
    when 'forward'
      @x += value
      @y += @aim * value
    when 'down'
      @aim += value
    when 'up'
      @aim -= value
    end
  end
  puts @x * @y
end

file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

@x = 0
@y = 0
@aim = 0

part2(file_data)