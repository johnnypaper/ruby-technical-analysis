module RubyTechnicalAnalysis
  # Mass Index
  #
  # Find more information at: https://www.investopedia.com/terms/m/mass-index.asp
  class MassIndex < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

    def call
      calculate_mass_index
    end

    private

    def _highs
      @_highs ||= price_series.map(&:first).last(_full_period)
    end

    def lows
      price_series.map(&:last).last(_full_period)
    end

    def _full_period
      @_full_period ||= (2 * period + 1)
    end

    def _low_multiple
      @_low_multiple ||= (2.0 / (period + 1)).truncate(4)
    end

    def high_multiple
      1 - _low_multiple
    end

    def high_minus_low_array
      (0..(_highs.size - 1)).map { |index| _highs.at(index) - lows.at(index) }
    end

    def _high_minus_low_ema_array
      @_high_minus_low_ema_array ||= high_minus_low_array.each_with_index.reduce([]) do |arr, (value, index)|
        arr << (index.zero? ? value.truncate(4) : ((value * _low_multiple) + (arr.at(index - 1) * high_multiple)).truncate(4))
      end
    end

    def high_minus_low_ema_ema_array
      [*0..period + 1].each.reduce([]) do |arr, index|
        arr << (index.zero? ? _high_minus_low_ema_array.at(period - index - 1) : ((_high_minus_low_ema_array.at(period + index - 1) * 0.2) + (arr.last * 0.8)).round(4))
      end
    end

    def calculate_mass_index
      [*0..2].each.sum do |index|
        (_high_minus_low_ema_array.at((period * 2) + index - 2) / high_minus_low_ema_ema_array.at(period + index - 1))
      end.round(4)
    end
  end
end
