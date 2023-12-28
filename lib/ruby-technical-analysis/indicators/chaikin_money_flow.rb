# frozen_string_literal: true

require_relative "indicator"

module RTA
  # Chaikin Money Flow indicator
  # Returns a current singular value
  class ChaikinMoneyFlow < Indicator
    attr_accessor :cmf_sum, :vol_sum
    attr_reader :period

    def initialize(price_series, period)
      @period = period
      @cmf_sum = 0
      @vol_sum = 0

      super(price_series)
    end

    def call
      highs, lows, closes, volumes = extract_highs_lows_closes_volumes(period)

      period.times do |i|
        self.vol_sum += volumes.at(i)

        close_minus_low = closes.at(i) - lows.at(i)
        high_minus_close = highs.at(i) - closes.at(i)
        high_minus_low = highs.at(i) - lows.at(i)

        self.cmf_sum += ((close_minus_low - high_minus_close).to_f / high_minus_low) * volumes.at(i)
      end

      (vol_sum.zero? ? 0 : cmf_sum.to_f / vol_sum).round(5)
    end
  end
end
