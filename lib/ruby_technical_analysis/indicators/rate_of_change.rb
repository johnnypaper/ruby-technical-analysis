module RubyTechnicalAnalysis
  # Rate Of Change
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/roc
  class RateOfChange < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

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
