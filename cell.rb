# frozen_string_literal: true

# Represents a cell and its state information
class Cell
  attr_accessor :state, :next_state

  def initialize(state)
    @state = state
  end
end
