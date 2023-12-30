module RubyTechnicalAnalysis
  # Rate Of Change
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/roc
  class RateOfChange < Indicator
    attr_reader :period

    # @param price_series [Array] An array of prices, typically closing prices
    # @param period [Integer] The number of periods to use in the calculation, default is 3
    def initialize(price_series, period = 3)
      @period = period

      super(price_series)
    end

    # @return [Float] The current ROC value
    def call
      calculate_roc
    end

    private

    def calculate_roc
      (((current_price - lookback_price).to_f / lookback_price) * 100).round(2)
    end

    def current_price
      price_series.last
    end

    def lookback_price
      price_series.last(period + 1).first
    end
  end
end
