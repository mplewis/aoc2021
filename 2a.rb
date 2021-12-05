# frozen_string_literal: true

require_relative 'lib'

$pos = 0
$dep = 0

def move(verb, count)
  if verb == 'forward'
    $pos += count
  elsif verb == 'up'
    $dep -= count
  elsif verb == 'down'
    $dep += count
  else
    raise "Invalid verb: #{verb}"
  end
end

lines('2a.txt').each do |line|
  verb, count = line.split ' '
  move(verb, count.to_i)
end

puts $pos, $dep
puts $pos * $dep
