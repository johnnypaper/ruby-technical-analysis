# frozen_string_literal: true

require_relative "indicator"
require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Volume Oscillator indicator
  # Returns a single value
  class VolumeOscillator < Indicator
    attr_reader :short_ma, :long_ma

    def initialize(price_series, short_ma, long_ma)
      @short_ma = short_ma
      @long_ma = long_ma

      super(price_series)
    end

    def call
      calculate_volume_oscillator
    end

    private

    def short_ma_a
      (0..(price_series.length - short_ma)).map do |i|
        RTA::MovingAverages.new(price_series[i..(i + short_ma - 1)]).sma(short_ma)
      end
    end

    def _long_ma_a
      @_long_ma_a ||= (0..(price_series.length - long_ma)).map do |i|
        RTA::MovingAverages.new(price_series[i..(i + long_ma - 1)]).sma(long_ma)
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
