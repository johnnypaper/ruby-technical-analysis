module RubyTechnicalAnalysis
  # Commodity Channel Index
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/cci
  class CommodityChannelIndex < Indicator
    attr_reader :period

    # @param series [Array] An array of arrays containing high, low, close information, e.g. [[high, low, close], [high, low, close]]
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(series: [], period: 20)
      @period = period

      super(series: series)
    end

    # @return [Float] The current Commodity Channel Index value
    def call
      calculate_cci
    end

    private

    def min_size
      (period * 2 - 1)
    end

    def calculate_typical_prices
      highs, lows, closes = extract_highs_lows_closes(subset_length: min_size)

      highs.zip(lows, closes).map { |high, low, close| (high + low + close) / 3 }
    end

    def _typical_prices
      @_typical_prices ||= calculate_typical_prices
    end

    def _typical_prices_sma
      @_typical_prices_sma ||=
        _typical_prices.each_cons(period).map do |tp|
          RubyTechnicalAnalysis::MovingAverages.new(series: tp, period: period).sma
        end
    end

    def _period_sum
      @_period_sum ||=
        _typical_prices.last(period).sum do |tp|
          (_typical_prices_sma.last - tp).abs
        end
    end

    def _period_sum_next_period
      @_period_sum_next_period ||=
        (_period_sum.to_f / period) * 0.015
    end

    def _typical_prices_sma_minus_typical_prices
      @_typical_prices_sma_minus_typical_prices ||=
        _typical_prices.last(period).last - _typical_prices_sma.last
    end

    def calculate_cci
      (_typical_prices_sma_minus_typical_prices.to_f / _period_sum_next_period)
    end
  end
end
