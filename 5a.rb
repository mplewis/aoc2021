# frozen_string_literal: true

require_relative 'lib'

def horizvert?(x1, y1, x2, y2)
  x1 == x2 || y1 == y2
end

raw = lines '5.txt'
pairs = raw.map do |pair|
  match = pair.match(/(\d+),(\d+) -> (\d+),(\d+)/)
  x1, y1, x2, y2 = match.captures.map(&:to_i)
  [x1, y1, x2, y2]
end

hv = pairs.select { |pair| horizvert?(*pair) }

map = Hash.new 0
hv.each do |pair|
  x1, y1, x2, y2 = pair
  x1, x2 = x2, x1 if x1 > x2
  y1, y2 = y2, y1 if y1 > y2
  (x1..x2).each do |x|
    (y1..y2).each do |y|
      map["#{x},#{y}"] += 1
    end
  end
end

puts map.values.select { |v| v > 1 }.count
