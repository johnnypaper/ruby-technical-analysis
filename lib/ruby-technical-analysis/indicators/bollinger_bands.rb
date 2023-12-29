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
      calculate_bollinger_bands
    end

    private

    def _middle_price
      @_middle_price ||= moving_averages.sma(period)
    end

    def _twice_sd
      @_twice_sd ||= 2 * statistical_methods.standard_deviation
    end

    def upper_band
      _middle_price + _twice_sd
    end

    def lower_band
      _middle_price - _twice_sd
    end

    def calculate_bollinger_bands
      [upper_band, _middle_price, lower_band].map { |n| n.truncate(3) }
    end
  end
end
