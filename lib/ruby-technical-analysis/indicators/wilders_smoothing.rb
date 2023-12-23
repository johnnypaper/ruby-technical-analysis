# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Wilders Smoothing indicator
  # Returns a singular current value
  class WildersSmoothing
    attr_reader :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      ws = _sma_first_period

      (0..smoothing_length).each do |i|
        ws << ((price_series.at(i + period) - ws.at(i)) * (1.0 / period)) + ws.at(i)
      end

      ws.last
    end

    private

    def _sma_first_period
      @_sma_first_period ||=
        Array(RTA::MovingAverages.new(price_series.first(period)).sma(period))
    end

    def smoothing_length
      (price_series.size - period - 1)
    end
  end
end
