module RubyTechnicalAnalysis
  # RateOfChange indicator
  # Returns a single value
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
