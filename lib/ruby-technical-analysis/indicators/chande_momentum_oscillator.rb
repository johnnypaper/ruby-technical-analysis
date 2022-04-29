# frozen_string_literal: true

# Chaikin Money Flow indicator
# Returns a current singular value
module ChandeMomentumOscillator
  def chande_momentum_oscillator(period)
    if size < period + 1
      raise ArgumentError,
            "Array size is less than the minimum size of the period + 1 for the Chande Momentum Oscillator."
    end

    closes = last(period + 1)

    up_change_sum = 0
    down_change_sum = 0

    (1..period).each do |i|
      if closes[i] >= closes[i - 1]
        up_change_sum += (closes[i] - closes[i - 1])
      else
        down_change_sum += (closes[i - 1] - closes[i])
      end
    end

    up_sum_minus_down_sum = up_change_sum - down_change_sum
    up_sum_plus_down_sum = up_change_sum + down_change_sum

    ((up_sum_minus_down_sum.to_f / up_sum_plus_down_sum) * 100).round(4)
  end
end

class Array
  include ChandeMomentumOscillator
end
