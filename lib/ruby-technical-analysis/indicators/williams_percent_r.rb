# frozen_string_literal: true

module RTA
  # Williams Percent R indicator
  # Returns a single value
  class WilliamsPercentR
    attr_accessor :highest_highs, :lowest_lows, :highest_highs_minus_close,
                  :highest_highs_minus_lowest_lows, :pct_r

    attr_reader :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
      @highest_highs = []
      @lowest_lows = []
      @highest_highs_minus_close = []
      @highest_highs_minus_lowest_lows = []
      @pct_r = []
    end

    def call
      highs, lows, closes = extract_prices(price_series)

      (0..highs.length - period).each do |i|
        calculate_highest_highs(highs, i)
        calculate_lowest_lows(lows, i)
        calculate_highest_highs_minus_close(closes, i)
        calculate_highest_highs_minus_lowest_lows
        calculate_pct_r
      end

      pct_r.last
    end

    private

    def extract_prices(price_series)
      highs, lows, closes = price_series.transpose

      [highs, lows, closes]
    end

    def calculate_lowest_lows(lows, window_start)
      lowest_lows << lows[window_start..(period - 1 + window_start)].min
    end

    def calculate_highest_highs(highs, window_start)
      highest_highs << highs[window_start..(period - 1 + window_start)].max
    end

    def calculate_highest_highs_minus_close(closes, window_start)
      highest_highs_minus_close <<
        (highest_highs.last - closes.at(period - 1 + window_start)).round(2)
    end

    def calculate_highest_highs_minus_lowest_lows
      highest_highs_minus_lowest_lows << (highest_highs.last - lowest_lows.last).round(4)
    end

    def calculate_pct_r
      pct_r <<
        ((highest_highs_minus_close.last.to_f / highest_highs_minus_lowest_lows.last) * -100).round(2)
    end
  end
end
