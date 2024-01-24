module Rta
  # Volume Oscillator
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/volume-oscillator
  class VolumeOscillator < Indicator
    attr_reader :short_ma_period, :long_ma_period

    # @param series [Array] An array of volume values
    # @param short_ma_period [Integer] The number of periods to use in the calculation of the short moving average
    # @param long_ma_period [Integer] The number of periods to use in the calculation of the long moving average
    def initialize(series: [], short_ma_period: 20, long_ma_period: 60)
      @short_ma_period = short_ma_period
      @long_ma_period = long_ma_period

      super(series: series)
    end

    # @return [Float] The current volume oscillator value
    def call
      calculate_volume_oscillator
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      short_ma_period < long_ma_period && long_ma_period <= series.length
    end

    private

    def short_ma_a
      (0..(series.length - short_ma_period)).map do |index|
        Rta::MovingAverages.new(series: series[index..(index + short_ma_period - 1)], period: short_ma_period).sma
      end
    end

    def _long_ma_a
      @_long_ma_a ||= (0..(series.length - long_ma_period)).map do |index|
        Rta::MovingAverages.new(series: series[index..(index + long_ma_period - 1)], period: long_ma_period).sma
      end
    end

    def short_minus_long_ma_a
      (short_ma_a.last - _long_ma_a.last).round(2)
    end

    def calculate_volume_oscillator
      ((short_minus_long_ma_a.to_f / _long_ma_a.last) * 100).round(2)
    end
  end
end
