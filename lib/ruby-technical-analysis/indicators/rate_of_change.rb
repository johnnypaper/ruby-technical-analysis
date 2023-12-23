# frozen_string_literal: true

module RTA
  # RateOfChange indicator
  # Returns a single value
  class RateOfChange
    attr_reader :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      (((price_series[-1] - price_series.last(period + 1)[0]).to_f / price_series.last(period + 1)[0]) * 100).round(2)
    end
  end
end
