# frozen_string_literal: true

require './grid'
require './cell'

# For now we only work with the following fixed grid (0 = no cell, 1 = dead cell, 2 = live cell)
# 1	1	2	2	0
# 0	2	1	1	1
# 1	2	2	1	0
# 1	1	2	0	0
# 2	1	2	1	2
# The expected next generation for this grid is
# 1 1 2 1 0
# 0 2 1 2 1
# 1 2 2 1 0
# 1 1 2 0 0
# 1 2 1 2 1
size = 5
cells = [
  [Cell.new(:dead), nil, Cell.new(:dead), Cell.new(:dead), Cell.new(:alive)],
  [Cell.new(:dead), Cell.new(:alive), Cell.new(:alive), Cell.new(:dead), Cell.new(:dead)],
  [Cell.new(:alive), Cell.new(:dead), Cell.new(:alive), Cell.new(:alive), Cell.new(:alive)],
  [Cell.new(:alive), Cell.new(:dead), Cell.new(:dead), nil, Cell.new(:dead)],
  [nil, Cell.new(:dead), nil, nil, Cell.new(:alive)]
]

grid = Grid.new(size, cells)
puts 'Welcome!'
grid.print

answer = nil
while answer != 'n'
  puts 'Do you want to see the next generation (y/n)?'
  answer = gets.chomp.downcase
  puts ''
  case answer
  when 'y'
    grid.prepare_next_generation
    grid.apply_next_generation
    grid.print
  when 'n'
    puts 'Goodbye!'
  else
    puts "Invalid answer: please type 'y' or 'n'"
  end
end
