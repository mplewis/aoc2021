# frozen_string_literal: true

def lines(fn)
  open(fn).read.split(/\n/)
end
