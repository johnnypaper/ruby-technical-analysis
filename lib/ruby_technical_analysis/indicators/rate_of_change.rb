module RubyTechnicalAnalysis
  # Rate Of Change
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/roc
  class RateOfChange < Indicator
    attr_reader :period

    # @param series [Array] An array of prices, typically closing prices
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(series: [], period: 30)
      @period = period

      super(series: series)
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
      series.last
    end

    def lookback_price
      series.last(period + 1).first
    end
  end
end
