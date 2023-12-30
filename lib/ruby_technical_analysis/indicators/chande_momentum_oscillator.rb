module RubyTechnicalAnalysis
  # Chaikin Money Flow indicator
  # Returns a current singular value
  class ChandeMomentumOscillator < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period
      @up_change_sum = 0
      @down_change_sum = 0

      super(price_series)
    end

    def call
      calculate_cmo
    end

    private

    def _closes
      @_closes ||= extract_series(period + 1)
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
