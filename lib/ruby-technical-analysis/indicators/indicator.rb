# Frozen_string_literal: true

module RTA
  # Base class for indicators
  class Indicator
    attr_reader :price_series

    def self.call(*args)
      new(*args).call
    end

    def initialize(price_series)
      @price_series = price_series
    end

    private

    def extract_highs_lows_closes_volumes(period = nil)
      series = period ? @price_series.last(period) : @price_series

      highs, lows, closes, volumes = series.transpose

      [highs, lows, closes, volumes]
    end
  end
end