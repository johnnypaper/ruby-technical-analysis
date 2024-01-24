module RubyTechnicalAnalysis
  # Moving Average Convergence Divergence (MACD)
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/macd
  class Macd < Indicator
    attr_reader :fast_period, :slow_period, :signal_period

    # @param series [Array] An array of prices, typically closing prices
    # @param fast_period [Integer] The number of periods to use in the fast calculation
    # @param slow_period [Integer] The number of periods to use in the slow calculation
    # @param signal_period [Integer] The number of periods to use in the signal calculation
    def initialize(series: [], fast_period: 12, slow_period: 26, signal_period: 9)
      @fast_period = fast_period
      @slow_period = slow_period
      @signal_period = signal_period

      super(series: series)
    end

    # @return [Array] An array containing the current MACD line, signal line, and histogram values
    def call
      calculate_macd
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      series.length >= slow_period + signal_period
    end

    private

    def fast_pct
      (2.0 / (fast_period + 1)).truncate(6)
    end

    def slow_pct
      (2.0 / (slow_period + 1)).truncate(6)
    end

    def period_array(percent)
      period_values = Array(series.first)

      series.drop(1).each_with_index do |value, index|
        period_values << ((value * percent) + (period_values.last * (1 - percent))).round(3)
      end

      period_values
    end

    def _fast_period_array
      @_fast_period_array ||= period_array(fast_pct)
    end

    def _slow_period_array
      @_slow_period_array ||= period_array(slow_pct)
    end

    def _signal_array
      @_signal_array ||= (0..signal_period - 1).map do |index|
        calculated_index = slow_period + index - 1

        (_fast_period_array.at(calculated_index) - _slow_period_array.at(calculated_index)).round(3)
      end
    end

    def _signal_pct
      @_signal_pct ||= (2.0 / (signal_period + 1)).truncate(6)
    end

    def _signal
      @_signal ||= ((_signal_array.last * _signal_pct) + (_signal_array.at(-2) * (1 - _signal_pct))).round(3)
    end

    def _macd_line
      @_macd_line ||= (_fast_period_array.last - _slow_period_array.last).round(4)
    end

    def histogram
      (_macd_line - _signal).round(3)
    end

    def calculate_macd
      [_macd_line, _signal, histogram]
    end
  end
end
