# frozen_string_literal: true

require_relative "indicator"
require_relative "../../ruby-technical-analysis/moving_averages"
require_relative "../../ruby-technical-analysis/statistical_methods"

module RTA
  # Bollinger Bands indicator
  # Returns an array containing the current upper, middle, and lower bands of the series
  class BollingerBands < Indicator
    attr_reader :period

    def initialize(price_series, period = 5)
      @period = period

      super(price_series)
    end

    def call
      middle = moving_averages.sma(period)
      twice_sd = 2 * statistical_methods.standard_deviation
      upper = (middle + twice_sd)
      lower = (middle - twice_sd)

      [upper, middle, lower].map { |n| n.truncate(3) }
    end
  end
end
