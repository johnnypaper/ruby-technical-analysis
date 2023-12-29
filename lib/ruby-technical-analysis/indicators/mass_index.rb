# frozen_string_literal: true

require_relative "indicator"
require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Mass Index indicator
  # Returns a singular current value
  class MassIndex < Indicator
    attr_accessor :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

    def call
      calculate_mass_index
    end

    private

    def _highs
      @_highs ||= price_series.map(&:first).last(_full_period)
    end

    def lows
      price_series.map(&:last).last(_full_period)
    end

    def _full_period
      @_full_period ||= (2 * period + 1)
    end

    def _low_multiple
      @_low_multiple ||= (2.0 / (period + 1)).truncate(4)
    end

    def high_multiple
      1 - _low_multiple
    end

    def high_minus_low_array
      (0..(_highs.size - 1)).map { |i| _highs.at(i) - lows.at(i) }
    end

    def _high_minus_low_ema_array
      @_high_minus_low_ema_array ||= high_minus_low_array.each_with_index.reduce([]) do |arr, (i, index)|
        arr << (index.zero? ? i.truncate(4) : ((i * _low_multiple) + (arr.at(index - 1) * high_multiple)).truncate(4))
      end
    end

    def high_minus_low_ema_ema_array
      [*0..period + 1].each.reduce([]) do |arr, i|
        arr << (i.zero? ? _high_minus_low_ema_array.at(period - i - 1) : ((_high_minus_low_ema_array.at(period + i - 1) * 0.2) + (arr.last * 0.8)).round(4)) # rubocop:disable Layout/LineLength
      end
    end

    def calculate_mass_index
      [*0..2].each.sum do |i|
        (_high_minus_low_ema_array.at((period * 2) + i - 2) / high_minus_low_ema_ema_array.at(period + i - 1))
      end.round(4)
    end
  end
end
