# frozen_string_literal: true

require './grid'
require './cell'

def init_random_cell
  random_number = rand(0..2)
  case random_number
  when 0
    nil
  when 1
    Cell.new(:dead)
  else
    Cell.new(:alive)
  end
end

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

# Default grid (0 = no cell, 1 = dead cell, 2 = live cell)
# 1	1	2	2	0
# 0	2	1	1	1
# 1	2	2	1	0
# 1	1	2	0	0
# 2	1	2	1	2
# Expected next generation for this grid
# 1 1 2 1 0
# 0 2 1 2 1
# 1 2 2 1 0
# 1 1 2 0 0
# 1 2 1 2 1

max_generation = 50

init_mode = nil
until %w[d r].include?(init_mode)
  puts 'Welcome! Do you want the default grid (d) or a random grid (r)?'
  init_mode = gets.chomp.downcase
  puts ''
  case init_mode
  when 'd'
    size = 5
    cells = [
      [Cell.new(:dead), nil, Cell.new(:dead), Cell.new(:dead), Cell.new(:alive)],
      [Cell.new(:dead), Cell.new(:alive), Cell.new(:alive), Cell.new(:dead), Cell.new(:dead)],
      [Cell.new(:alive), Cell.new(:dead), Cell.new(:alive), Cell.new(:alive), Cell.new(:alive)],
      [Cell.new(:alive), Cell.new(:dead), Cell.new(:dead), nil, Cell.new(:dead)],
      [nil, Cell.new(:dead), nil, nil, Cell.new(:alive)]
    ]
  when 'r'
    size = nil
    until !size.nil? && !Integer(size, exception: false).nil? && Integer(size).positive?
      puts 'Enter the desired size of the grid:'
      size = gets.chomp.downcase
      puts ''
    end
    size = Integer(size)
    cells = Array.new(size) { Array.new(size) { init_random_cell } }
  else puts "Invalid answer: please type 'd' or 'r'"
  end
end

puts 'Here is your starting grid:'
grid = Grid.new(size, cells, max_generation)
grid.print

run_mode = nil
until %w[d s].include?(run_mode)
  puts 'Do you want the simulation to run until all the cells die (d) or do you want to run it step-by-step (s)?'
  run_mode = gets.chomp.downcase
  puts ''
  case run_mode
  when 'd' then run_until_death(grid)
  when 's' then run_step_by_step(grid)
  else puts "Invalid answer: please type 'd' or 's'"
  end
end
