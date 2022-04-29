# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

# Moving Average Convergence Divergence (MACD) indicator
# Returns an array of current macd value and signal value
module Macd
  def macd(fast_period, slow_period, signal_period)
    if size < (slow_period + signal_period)
      raise ArgumentError,
            "Closes array passed to MACD cannot be less than the (slow period + signal period) arguments."
    end

    fast_pct = (2.0 / (fast_period + 1)).truncate(6)
    slow_pct = (2.0 / (slow_period + 1)).truncate(6)
    sig_pct = (2.0 / (signal_period + 1)).truncate(6)

    fast_arr = []
    slow_arr = []

    seed = true
    each do |i|
      if seed
        fast_arr << i
        slow_arr << i
        seed = false
      else
        fast_arr << ((i * fast_pct) + ((fast_arr[-1]) * (1 - fast_pct))).round(3)
        slow_arr << ((i * slow_pct) + ((slow_arr[-1]) * (1 - slow_pct))).round(3)
      end
    end

    sig_arr = []

    (0..signal_period - 1).each do |i|
      sig_arr << (fast_arr[slow_period + i - 1] - slow_arr[slow_period + i - 1]).round(3)
    end

    signal = ((sig_arr[-1] * sig_pct) + ((sig_arr[-2]) * (1 - sig_pct))).round(3)

    [(fast_arr[-1] - slow_arr[-1]).round(4), signal, (fast_arr[-1] - slow_arr[-1]).round(4) - signal]
  end
end

class Array
  include Macd
end
