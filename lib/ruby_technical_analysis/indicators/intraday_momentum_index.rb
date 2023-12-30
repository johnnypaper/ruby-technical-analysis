module RubyTechnicalAnalysis
  # Intraday Momentum Index indicator
  # Returns a singular current value
  class IntradayMomentumIndex < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period
      @gsum = 0
      @lsum = 0

      super(price_series)
    end

    def call
      calculate_imi
    end

    private

    def calculate_gsum_plus_lsum
      price_series.last(period).each do |open, close|
        cmo = (close - open).abs
        (close > open) ? @gsum += cmo : @lsum += cmo
      end

      @gsum + @lsum
    end

    def calculate_imi
      gsum_plus_lsum = calculate_gsum_plus_lsum

      (gsum_plus_lsum.zero? ? 0 : (@gsum / gsum_plus_lsum) * 100).round(4)
    end
  end
end
