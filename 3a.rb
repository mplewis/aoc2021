# frozen_string_literal: true

require_relative 'lib'

gbits = []
ebits = []
lines('3a.txt').map(&:chars).transpose.each do |chars|
  if chars.count('0') > chars.count('1')
    gbits.push('0')
    ebits.push('1')
  else
    gbits.push('1')
    ebits.push('0')
  end
end

gamma = gbits.join('').to_i(2)
epsilon = ebits.join('').to_i(2)
puts gamma, epsilon, gamma * epsilon
