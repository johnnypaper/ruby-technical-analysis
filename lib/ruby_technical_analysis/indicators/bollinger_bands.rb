module RubyTechnicalAnalysis
  # Bollinger Bands
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/bollinger-bands
  class BollingerBands < Indicator
    attr_reader :period

    # @param price_series [Array] An array of prices, typically closing prices
    # @param period [Integer] The number of periods to use in the calculation
    # @param standard_deviations [Integer] The number of standard deviations to use in the calculation
    def initialize(price_series, period = 20, standard_deviations = 2)
      @period = period
      @standard_deviations = standard_deviations

      super(price_series)
    end

    # @return [Array] An array containing the current upper, middle, and lower bands of the series
    def call
      calculate_bollinger_bands
    end

    private

    def _middle_price
      @_middle_price ||= moving_averages(period: period).sma
    end

    def _twice_sd
      @_twice_sd ||= @standard_deviations * statistical_methods.standard_deviation
    end

    def upper_band
      _middle_price + _twice_sd
    end

    def lower_band
      _middle_price - _twice_sd
    end

    def calculate_bollinger_bands
      [upper_band, _middle_price, lower_band].map { |band| band.truncate(3) }
    end
  end
end
