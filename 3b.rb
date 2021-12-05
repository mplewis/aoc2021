# frozen_string_literal: true

require_relative 'lib'

table = lines('3a.txt').map(&:chars)

def find_oxygen(data)
  oxys = data.clone
  for bit_pos in 0...oxys.first.count
    ones = 0
    total = oxys.count

    for line in oxys
      if line[bit_pos] == '1'
        ones += 1
      end
    end

    if ones >= total / 2.0
      goal = '1'
    else
      goal = '0'
    end
    oxys.filter! { |line| line[bit_pos] == goal }

    if oxys.count == 1
      return oxys.first.join
    end
  end
end

def find_cos(data)
  cos = data.clone
  for bit_pos in 0...cos.first.count
    zeroes = 0
    total = cos.count

    for line in cos
      if line[bit_pos] == '0'
        zeroes += 1
      end
    end

    if zeroes <= total / 2.0
      goal = '0'
    else
      goal = '1'
    end
    cos.filter! { |line| line[bit_pos] == goal }

    if cos.count == 1
      return cos.first.join
    end
  end
end

oxy = find_oxygen(table)
co = find_cos(table)
puts oxy, co, oxy.to_i(2) * co.to_i(2)
