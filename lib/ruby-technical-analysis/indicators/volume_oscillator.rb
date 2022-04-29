# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

# Volume Oscillator indicator
# Returns a single value
module VolumeOscillator
  def volume_oscillator(short_ma, long_ma)
    if size < long_ma
      raise ArgumentError,
            "Volumes array passed to Volume Oscillator cannot be less than the Long Moving Average argument."
    end

    if long_ma <= short_ma
      raise ArgumentError,
            "Long Moving Average parameter must be greater than Short Moving Average parameter in Volume Oscillator."
    end

    short_ma_a = []
    long_ma_a = []

    (0..(length - short_ma)).each do |i|
      short_ma_a << self[i..(i + short_ma - 1)].sma(short_ma)
    end

    (0..(length - long_ma)).each do |i|
      long_ma_a << self[i..(i + long_ma - 1)].sma(long_ma)
    end

    sml = (short_ma_a.last - long_ma_a.last).round(2)

    ((sml.to_f / long_ma_a.last) * 100).round(2)
  end
end

class Array
  include VolumeOscillator
end
