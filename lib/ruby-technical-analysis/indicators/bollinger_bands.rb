# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"
require_relative "../../ruby-technical-analysis/statistical_methods"

# Bollinger Bands indicator
# Returns an array containing the current upper, middle, and lower bands of the series
module BollingerBands
  def bollinger_bands(period)
    if size < period
      raise ArgumentError,
            "Array passed to Bollinger Bands cannot be less than the period argument."
    end
    closes = last(period)
    middle = closes.sma(period)
    twice_sd = (2 * RTA::StatisticalMethods.new(closes).standard_deviation).truncate(4)
    upper = twice_sd + middle
    lower = middle - twice_sd
    [upper, middle, lower]
  end
end

class Array
  include BollingerBands
end
