# frozen_string_literal: true

def gamma(matrix)
  gamma = []
  matrix.each do |line|
    count0 = line.count(0)
    count1 = line.count(1)
    gamma.push(count0 > count1 ? 0 : 1)
  end
  gamma
end

def epsilon(matrix)
  gamma = []
  matrix.each do |line|
    count0 = line.count(0)
    count1 = line.count(1)
    gamma.push(count0 > count1 ? 1 : 0)
  end
  gamma
end

file = File.open('input.txt')
file_data = file.readlines(&:chomp)
file_data.map! { |line| line.strip.split('') }
@report = file_data.map { |line| line.map!(&:to_i) }

#@rotated = @report.transpose

# gamma.join('').to_i(2)

index = 0
while @report.size > 1
  g = gamma(@report.transpose)
  @report.select! { |line| line[index] == g[index] }
  index += 1
end

puts @report.join('').to_i(2)
puts @report.map { |x| x.join(' ') }
