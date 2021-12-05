# frozen_string_literal: true

require_relative 'lib'

data = lines '1a.txt'
greater = 0
last = nil
data.each do |curr|
  puts "#{last} #{curr}"
  if last && curr > last
    greater += 1
    puts '+'
  end
  last = curr
end

puts greater
