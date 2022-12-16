# frozen_string_literal: true

require './cell'

# Represents a grid filled with cells
class Grid
  attr_accessor :size, :generation, :cells

  def initialize(size, cells)
    @size = size
    @generation = 0
    @cells = cells
  end

  def prepare_next_generation
    (0..size - 1).each do |i|
      (0..size - 1).each do |j|
        cell = cells[i][j]
        cell&.compute_next_state(count_live_neighbors(i, j))
      end
    end
  end

  def apply_next_generation
    (0..size - 1).each do |i|
      (0..size - 1).each do |j|
        cell = cells[i][j]
        cell&.apply_next_state
      end
    end
    @generation += 1
  end

  def count_live_neighbors(i_cell, j_cell)
    live_neighbors = 0
    [i_cell - 1, i_cell, i_cell + 1].each do |i_neighbor|
      [j_cell - 1, j_cell, j_cell + 1].each do |j_neighbor|
        next unless valid_coords?(i_neighbor, j_neighbor)
        next if i_neighbor == i_cell && j_neighbor == j_cell

        live_neighbors += 1 if alive_cell?(i_neighbor, j_neighbor)
      end
    end
    live_neighbors
  end

  def valid_coords?(i_cell, j_cell)
    i_cell >= 0 && i_cell < size && j_cell >= 0 && j_cell < size
  end

  def alive_cell?(i_cell, j_cell)
    cell = cells[i_cell][j_cell]
    !cell.nil? && cell.state == :alive
  end

  def print
    puts "Generation #{generation}:"
    (0..size - 1).each do |row|
      line = ''
      (0..size - 1).each do |col|
        cell = cells[col][row]
        line += string_representation(cell)
      end
      puts line
    end
  end

  def string_representation(cell)
    if cell.nil?
      '0'
    elsif cell.state == :dead
      '1'
    else
      '2'
    end
  end
end
