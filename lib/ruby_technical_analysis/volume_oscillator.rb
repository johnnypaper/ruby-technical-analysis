module RubyTechnicalAnalysis
  # Volume Oscillator indicator
  # Returns a single value
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
      (0..(price_series.length - short_ma_period)).map do |i|
        RubyTechnicalAnalysis::MovingAverages.new(price_series[i..(i + short_ma_period - 1)], short_ma_period).sma
      end
    end

    def _long_ma_a
      @_long_ma_a ||= (0..(price_series.length - long_ma_period)).map do |i|
        RubyTechnicalAnalysis::MovingAverages.new(price_series[i..(i + long_ma_period - 1)], long_ma_period).sma
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
