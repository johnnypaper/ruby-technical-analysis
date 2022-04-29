# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

# Wilders Smoothing indicator
# Returns a singular current value
module WildersSmoothing
  def wilders_smoothing(period)
    if size < period
      raise ArgumentError,
            "Closes array passed to Wilders Smoothing cannot be less than the period argument."
    end

    ws = []
    ws << first(period).sma(period)

    (0..(size - period - 1)).each do |i|
      ws << ((at(i + period) - ws[i]) * (1.0 / period)) + ws[i]
    end

    ws[-1]
  end
end

class Array
  include WildersSmoothing
end
