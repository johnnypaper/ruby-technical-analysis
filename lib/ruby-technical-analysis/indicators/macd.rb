# frozen_string_literal: true

require_relative "indicator"
require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Moving Average Convergence Divergence (MACD) indicator
  # Returns an array of current macd value and signal value
  class Macd < Indicator
    attr_accessor :fast_period, :slow_period, :signal_period

    def initialize(price_series, fast_period = 12, slow_period = 26, signal_period = 9)
      @fast_period = fast_period
      @slow_period = slow_period
      @signal_period = signal_period

      super(price_series)
    end

    def call
      calculate_macd
    end

    private

    def fast_pct
      (2.0 / (fast_period + 1)).truncate(6)
    end

    def slow_pct
      (2.0 / (slow_period + 1)).truncate(6)
    end

    def period_array(percent)
      price_series.each_with_index.reduce([]) do |arr, (i, index)|
        arr << (index.zero? ? i : ((i * percent) + (arr.last * (1 - percent))).round(3))
      end
    end

    def _fast_period_array
      @_fast_period_array ||= period_array(fast_pct)
    end

    def _slow_period_array
      @_slow_period_array ||= period_array(slow_pct)
    end

    def _signal_array
      @_signal_array ||= (0..signal_period - 1).map do |i|
        (_fast_period_array.at(slow_period + i - 1) - _slow_period_array.at(slow_period + i - 1)).round(3)
      end
    end

    def _signal_pct
      @_signal_pct ||= (2.0 / (signal_period + 1)).truncate(6)
    end

    def _signal
      @_signal ||= ((_signal_array.last * _signal_pct) + (_signal_array.at(-2) * (1 - _signal_pct))).round(3)
    end

    def _macd_line
      @_macd_line ||= (_fast_period_array.last - _slow_period_array.last).round(4)
    end

    def histogram
      (_macd_line - _signal).round(3)
    end

    def calculate_macd
      [_macd_line, _signal, histogram]
    end
  end
end
