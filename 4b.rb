# frozen_string_literal: true

require 'active_support/core_ext/array/grouping'

def parse(fn)
  chunks = open(fn).read.split("\n\n")
  calls = chunks.first.split(',').map(&:to_i)
  boards = chunks[1..-1].map { |b| parse_board(b) }
  [calls, boards]
end

def parse_board(raw)
  lines = raw.split("\n")
  lines.map { |l| l.scan(/(\d+)/).flatten.map(&:to_i) }
end

def mark(board, call)
  board.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell == call
        board[y][x] = :X
      end
    end
  end
end

def winner?(board)
  board.each do |row|
    return true if row.all? { |c| c == :X }
  end
  board.transpose.each do |col|
    return true if col.all? { |c| c == :X }
  end
  false
end

def find_losing_board(calls, boards)
  loser = nil
  calls.each_with_index do |call, i|
    boards.each_with_index do |board, j|
      mark(board, call)
      mark(loser, call) if loser
    end
    losers = boards.reject { |b| winner?(b) }
    loser = losers.first if losers.count == 1 && !loser
    return loser, call if loser && winner?(loser)
  end
end

calls, boards = parse('4.txt')
board, call = find_losing_board(calls, boards)
pp board
pp board.flatten
pp board.flatten.reject { |c| c == :X }
sum = board.flatten.reject { |c| c == :X }.sum
puts sum, call, sum * call
