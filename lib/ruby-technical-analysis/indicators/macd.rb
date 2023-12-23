# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Moving Average Convergence Divergence (MACD) indicator
  # Returns an array of current macd value and signal value
  class Macd
    attr_accessor :price_series, :fast_period, :slow_period, :signal_period

    def initialize(price_series, fast_period = 12, slow_period = 26, signal_period = 9)
      @price_series = price_series
      @fast_period = fast_period
      @slow_period = slow_period
      @signal_period = signal_period
    end

    def call
      fast_period_array = period_array(_fast_pct)
      slow_period_array = period_array(_slow_pct)

      signal_array = signal_array(fast_period_array, slow_period_array)
      signal = signal(signal_array, _signal_pct)

      macd_line = (fast_period_array.last - slow_period_array.last).round(4)
      histogram = (macd_line - signal).round(3)

      [macd_line, signal, histogram]
    end

    private

    def _fast_pct
      @_fast_pct ||= (2.0 / (fast_period + 1)).truncate(6)
    end

    def _slow_pct
      @_slow_pct ||= (2.0 / (slow_period + 1)).truncate(6)
    end

    def _signal_pct
      @_signal_pct ||= (2.0 / (signal_period + 1)).truncate(6)
    end

    def period_array(percent)
      arr = []

      price_series.each_with_index do |i, index|
        arr << (index.zero? ? i : ((i * percent) + (arr.last * (1 - percent))).round(3))
      end

      arr
    end

    def signal(signal_array, signal_pct)
      ((signal_array[-1] * signal_pct) + (signal_array[-2] * (1 - signal_pct))).round(3)
    end

    def signal_array(fast_array, slow_array)
      (0..signal_period - 1).map do |i|
        (fast_array[slow_period + i - 1] - slow_array[slow_period + i - 1]).round(3)
      end
    end
  end
end
