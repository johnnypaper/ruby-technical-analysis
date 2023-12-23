# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"
require_relative "../../ruby-technical-analysis/statistical_methods"

module RTA
  # Bollinger Bands indicator
  # Returns an array containing the current upper, middle, and lower bands of the series
  class BollingerBands
    attr_accessor :price_series, :period

    def initialize(price_series, period = 5)
      @price_series = price_series
      @period = period
    end

    def call
      middle = _moving_averages.sma(period)
      twice_sd = 2 * _statistical_methods.standard_deviation
      upper = (middle + twice_sd)
      lower = (middle - twice_sd)
      [upper, middle, lower].map { |n| n.truncate(3) }
    end

    private

    def _moving_averages
      @_moving_averages ||= RTA::MovingAverages.new(price_series)
    end

    def _statistical_methods
      @_statistical_methods ||= RTA::StatisticalMethods.new(price_series)
    end
  end
end
