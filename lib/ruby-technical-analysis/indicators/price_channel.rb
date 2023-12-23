# frozen_string_literal: true

module RTA
  # Price Channel indicator
  # Returns an array containing the current upper and lower values of the series
  class PriceChannel
    attr_reader :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      [upper_price_channel, lower_price_channel]
    end

    private

    def _highs
      @_highs ||= price_series.map { |i| i[0] }.last(period + 1)
    end

    def _lows
      @_lows ||= price_series.map { |i| i[1] }.last(period + 1)
    end

    def upper_price_channel
      _highs[0..period - 1].max
    end

    def lower_price_channel
      _lows[0..period - 1].min
    end
  end
end
