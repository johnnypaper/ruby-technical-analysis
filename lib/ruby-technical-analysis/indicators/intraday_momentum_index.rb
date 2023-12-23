# frozen_string_literal: true

module RTA
  # Intraday Momentum Index indicator
  # Returns a singular current value
  class IntradayMomentumIndex
    attr_accessor :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      gsum, lsum = calculate_gsum_lsum

      imi = calculate_imi(gsum, lsum)
      imi.round(4)
    end

    private

    def calculate_gsum_lsum
      gsum = 0.0
      lsum = 0.0

      price_series.last(period).each do |open, close|
        cmo = (close - open).abs
        close > open ? gsum += cmo : lsum += cmo
      end

      [gsum, lsum]
    end

    def calculate_imi(gsum, lsum)
      gsum_plus_lsum = gsum + lsum
      gsum_plus_lsum.zero? ? 0 : (gsum / gsum_plus_lsum) * 100
    end
  end
end
