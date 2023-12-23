# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Mass Index indicator
  # Returns a singular current value
  class MassIndex
    attr_accessor :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      high_minus_low_array = high_minus_low_array(_highs, _lows)
      high_minus_low_ema_array = high_minus_low_ema_array(high_minus_low_array)
      high_minus_low_ema_ema_array = high_minus_low_ema_ema_array(high_minus_low_ema_array)

      ema_regression(high_minus_low_ema_array, high_minus_low_ema_ema_array)
    end

    private

    def _highs
      @_highs ||= price_series.map(&:first).last(_full_period)
    end

    def _lows
      @_lows ||= price_series.map(&:last).last(_full_period)
    end

    def _full_period
      @_full_period ||= (2 * period + 1)
    end

    def _low_multiple
      @_low_multiple ||= (2.0 / (period + 1)).truncate(4)
    end

    def _high_multiple
      @_high_multiple ||= 1 - _low_multiple
    end

    def high_minus_low_array(highs, lows)
      (0..(highs.size - 1)).map { |i| highs[i] - lows[i] }
    end

    def high_minus_low_ema_array(high_minus_low_array)
      arr = []

      high_minus_low_array.each_with_index do |i, index|
        arr << (index.zero? ? i.truncate(4) : ((i * _low_multiple) + (arr[index - 1] * _high_multiple)).truncate(4))
      end

      arr
    end

    def high_minus_low_ema_ema_array(high_minus_low_ema_array)
      arr = []

      [*0..period + 1].each do |i|
        arr << (i.zero? ? high_minus_low_ema_array[period - i - 1] : ((high_minus_low_ema_array[period + i - 1] * 0.2) + (arr[-1] * 0.8)).round(4)) # rubocop:disable Layout/LineLength
      end

      arr
    end

    def ema_regression(high_minus_low_ema_array, high_minus_low_ema_ema_array)
      mi = 0
      [*0..2].each do |i|
        mi += ((high_minus_low_ema_array[(period * 2) + i - 2]) / (high_minus_low_ema_ema_array[period + i - 1]))
      end

      mi.round(4)
    end
  end
end
