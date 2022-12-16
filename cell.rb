# frozen_string_literal: true

# Represents a cell and its state information
class Cell
  attr_accessor :state, :next_state

  def initialize(state)
    @state = state
  end

  def compute_next_stage(live_neighbors)
    @next_stage = if (state == :alive && [2, 3].include?(live_neighbors)) || (state == :dead && live_neighbors == 3)
                    :alive
                  else
                    :dead
                  end
  end
end
