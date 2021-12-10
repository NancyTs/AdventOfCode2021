
def calculate_points(char)
  @points += 3 if char == ')'
  @points += 57 if char == ']'
  @points += 1197 if char == '}'
  @points += 25_137 if char == '>'
end

def calculate_points2(char)
  @points *= 5
  @points += 1 if char == '('
  @points += 2 if char == '['
  @points += 3 if char == '{'
  @points += 4 if char == '<'
end
# frozen_string_literal: true

class String
  def opening?
    true if eql?('(') || eql?('[') || eql?('{') || eql?('<')
  end

  def closing?
    true if eql?(')') || eql?(']') || eql?('}') || eql?('>')
  end
end

def matches?(open, close)
  return true if (open == '(') && (close == ')')
  return true if (open == '{') && (close == '}')
  return true if (open == '[') && (close == ']')
  return true if (open == '<') && (close == '>')
end

def matching_brace(char)
  return ')' if char == '('
  return ']' if char == '['
  return '}' if char == '{'
  return '>' if char == '<'
end

def part1(data)
  to_remove = []
  data.each_with_index do |line, index|
    newline = []
    line.split('').each do |char|
      newline.push(char) if char.opening?
      next unless char.closing?

      if matches?(newline.last, char)
        newline.pop
      else
        calculate_points(char)
        puts 'Illegal! ' + char
        to_remove.push(index)
        break
      end
    end
  end

  puts @points
  return to_remove
end

def part2(data)
  leftovers = []
  data.each do |line|
    newline = []
    line.split('').each do |char|
      newline.push(char) if char.opening?
      next unless char.closing?

      if matches?(newline.last, char)
        newline.pop
      end
    end
    leftovers.push(newline)
  end

  leftovers.each do |line|
    @points = 0
    line.reverse.each do |char|
      calculate_points2(char)
    end
    @points_array.push(@points)
  end

end

file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)
@points = 0

to_remove = part1(file_data).reverse
to_remove.each do |i|
  file_data.delete_at(i)
end

@points_array = []
part2(file_data)
@points_array.sort!
puts @points_array[@points_array.length/2]

