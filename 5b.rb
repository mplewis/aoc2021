# frozen_string_literal: true

require_relative 'lib'

def horizvert?(x1, y1, x2, y2)
  x1 == x2 || y1 == y2
end

def walk_diag(x1, y1, x2, y2)
  flip_x = false
  flip_y = false

  if x1 > x2
    x1, x2 = x2, x1
    flip_x = true
  end

  if y1 > y2
    y1, y2 = y2, y1
    flip_y = true
  end

  pairs = []
  y = y1
  (x1..x2).to_a.each do |x|
    pairs << [x, y]
    y += 1
  end

  tx = pairs.transpose
  tx[0].reverse! if flip_x
  tx[1].reverse! if flip_y
  tx.transpose
end

raw = lines '5.txt'
pairs = raw.map do |pair|
  match = pair.match(/(\d+),(\d+) -> (\d+),(\d+)/)
  x1, y1, x2, y2 = match.captures.map(&:to_i)
  [x1, y1, x2, y2]
end

# hv = pairs.select { |pair| horizvert?(*pair) }
hv = pairs

map = Hash.new 0
hv.each do |pair|
  if horizvert? *pair
    x1, y1, x2, y2 = pair
    x1, x2 = x2, x1 if x1 > x2
    y1, y2 = y2, y1 if y1 > y2
    (x1..x2).each do |x|
      (y1..y2).each do |y|
        map["#{x},#{y}"] += 1
      end
    end
  else
   walk_diag(*pair).each do |x, y|
      map["#{x},#{y}"] += 1
    end
  end
end

puts map.values.select { |v| v > 1 }.count
