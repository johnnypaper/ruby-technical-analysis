module RubyTechnicalAnalysis
  # Chande Momentum Oscillator
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/cmo
  class ChandeMomentumOscillator < Indicator
    attr_reader :period

    # @param series [Array] An array of prices, typically closing prices
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(series: [], period: 20)
      @period = period
      @up_change_sum = 0
      @down_change_sum = 0

      super(series: series)
    end

    # @return [Float] The current Chande Momentum Oscillator value
    def call
      calculate_cmo
    end

    private

    def _closes
      @_closes ||= extract_series(subset_length: period + 1)
    end

    def calculate_change_sums
      (1..period).each do |index|
        price_diff = _closes.at(index) - _closes.at(index - 1)
        @up_change_sum += price_diff if price_diff.positive?
        @down_change_sum -= price_diff if price_diff.negative?
      end

      @up_change_sum + @down_change_sum
    end

    def _up_sum_plus_down_sum
      @_up_sum_plus_down_sum ||= calculate_change_sums
    end

    def calculate_oscillator_value
      (@up_change_sum - @down_change_sum).to_f / _up_sum_plus_down_sum * 100
    end

    def calculate_cmo
      _up_sum_plus_down_sum.zero? ? 0 : calculate_oscillator_value.round(4)
    end
  end
end
