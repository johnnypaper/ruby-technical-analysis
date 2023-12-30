module RubyTechnicalAnalysis
  # Volume Oscillator
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/volume-oscillator
  class VolumeOscillator < Indicator
    attr_reader :short_ma_period, :long_ma_period

    def initialize(price_series, short_ma_period, long_ma_period)
      @short_ma_period = short_ma_period
      @long_ma_period = long_ma_period

      super(price_series)
    end

    def call
      calculate_volume_oscillator
    end

    private

    def short_ma_a
      (0..(price_series.length - short_ma_period)).map do |index|
        RubyTechnicalAnalysis::MovingAverages.new(price_series[index..(index + short_ma_period - 1)], short_ma_period).sma
      end
    end

    def _long_ma_a
      @_long_ma_a ||= (0..(price_series.length - long_ma_period)).map do |index|
        RubyTechnicalAnalysis::MovingAverages.new(price_series[index..(index + long_ma_period - 1)], long_ma_period).sma
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
