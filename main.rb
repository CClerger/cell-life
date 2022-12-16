# frozen_string_literal: true

require './grid'
require './cell'

def run_until_death(grid)
  print_next_generation(grid) until grid.final_state? || grid.max_generation_reached?
  puts 'All good things must come to an end.' if grid.max_generation_reached?
  puts 'Goodbye!'
end

def run_step_by_step(grid)
  answer = nil
  while answer != 'n'
    answer = ask_for_next_generation
    case answer
    when 'y' then print_next_generation(grid)
    when 'n' then puts 'Goodbye!'
    else puts "Invalid answer: please type 'y' or 'n'"
    end
  end
end

def ask_for_next_generation
  puts 'Do you want to see the next generation (y/n)?'
  gets.chomp.downcase
  puts ''
end

def print_next_generation(grid)
  grid.prepare_next_generation
  grid.apply_next_generation
  grid.print
end

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
max_generation = 50

grid = Grid.new(size, cells, max_generation)
puts 'Welcome! Here is your starting grid:'
grid.print

mode = nil
until %w[d s].include?(mode)
  puts 'Do you want the simulation to run until all the cells die (d) or do you want to run it step-by-step (s)?'
  mode = gets.chomp.downcase
  puts ''
  case mode
  when 'd' then run_until_death(grid)
  when 's' then run_step_by_step(grid)
  else puts "Invalid answer: please type 'd' or 's'"
  end
end
