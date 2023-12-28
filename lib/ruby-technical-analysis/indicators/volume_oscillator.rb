# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Volume Oscillator indicator
  # Returns a single value
  class VolumeOscillator
    attr_accessor :short_ma_a, :long_ma_a
    attr_reader :price_series, :short_ma, :long_ma

    def initialize(price_series, short_ma, long_ma)
      @price_series = price_series
      @short_ma = short_ma
      @long_ma = long_ma
      @short_ma_a = []
      @long_ma_a = []
    end

    def call
      calculate_short_ma_a
      calculate_long_ma_a

      ((short_minus_long_ma_a.to_f / long_ma_a.last) * 100).round(2)
    end

    private

    def calculate_short_ma_a
      (0..(price_series.length - short_ma)).each do |i|
        short_ma_a << RTA::MovingAverages.new(price_series[i..(i + short_ma - 1)]).sma(short_ma)
      end
    end

    def calculate_long_ma_a
      (0..(price_series.length - long_ma)).each do |i|
        long_ma_a << RTA::MovingAverages.new(price_series[i..(i + long_ma - 1)]).sma(long_ma)
      end
    end

    def short_minus_long_ma_a
      (short_ma_a.last - long_ma_a.last).round(2)
    end
  end
end
