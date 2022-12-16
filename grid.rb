# frozen_string_literal: true

# Represents a grid filled with cells
class Grid
  attr_accessor :size, :generation, :cells

  def initialize(size, cells)
    @size = size
    @generation = 0
    @cells = cells
  end
end
