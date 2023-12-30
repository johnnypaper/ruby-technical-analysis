module RubyTechnicalAnalysis
  # Intraday Momentum Index
  #
  # Find more information at: https://www.investopedia.com/terms/i/intraday-momentum-index-imi.asp
  class IntradayMomentumIndex < Indicator
    attr_reader :period

    # @param price_series [Array] An array of arrays containing open, close prices, e.g. [[open, close], [open, close]]
    # @param period [Integer] The number of periods to use in the calculation, default is 7
    def initialize(price_series, period = 7)
      @period = period
      @gsum = 0
      @lsum = 0

      super(price_series)
    end

    # @return [Float] The current Intraday Momentum Index value
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
