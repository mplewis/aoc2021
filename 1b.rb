# frozen_string_literal: true

require_relative 'lib'

# sliding window algorithm
def slide(data, size)
  (0..data.size - size).map { |i| data[i, size] }
end

data = lines '1a.txt'
greater = 0
last = nil
slide(data, 3).each do |group|
  curr = group.map(&:to_i).sum
  puts "#{last} #{curr}"
  if last && curr > last
    greater += 1
    puts '+'
  end
  last = curr
end

puts greater
