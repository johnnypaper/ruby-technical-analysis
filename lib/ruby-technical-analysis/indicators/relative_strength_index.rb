# frozen_string_literal: true

require_relative "indicator"
require_relative "wilders_smoothing"

module RTA
  # Relative Momentum Index indicator
  # Returns a single value
  class RelativeStrengthIndex < Indicator
    attr_accessor :wilders_is_set, :rsi, :smooth_up, :smooth_down
    attr_reader :period

    def initialize(price_series, period)
      @period = period
      @rsi = []
      @smooth_up = []
      @smooth_down = []
      @wilders_is_set = false

      super(price_series)
    end

    def call
      calculate_rsi
    end

    private

    def _smooth_coef_one
      @_smooth_coef_one ||= (1.0 / period).round(4)
    end

    def _smooth_coef_two
      @_smooth_coef_two ||= (1 - _smooth_coef_one)
    end

    def calculate_channels(cla)
      period.times.map do |i|
        diff = (cla.at(i) - cla.at(i + 1)).round(4)

        [diff.negative? ? diff.abs : 0, diff.positive? ? diff : 0]
      end.transpose
    end

    def calculate_initial_smoothing(up_ch, down_ch)
      smooth_up << RTA::WildersSmoothing.new(up_ch, period).call
      smooth_down << RTA::WildersSmoothing.new(down_ch, period).call

      self.wilders_is_set = true
    end

    def calculate_subsequent_smoothing(up_ch, down_ch)
      smooth_up << (_smooth_coef_one * up_ch.last + _smooth_coef_two * smooth_up.last).round(4)
      smooth_down << (_smooth_coef_one * down_ch.last + _smooth_coef_two * smooth_down.last).round(4)
    end

    def calculate_smoothing(up_ch, down_ch)
      wilders_is_set ? calculate_subsequent_smoothing(up_ch, down_ch) : calculate_initial_smoothing(up_ch, down_ch)
    end

    def calculate_rsi
      (0..(price_series.size - period - 1)).flat_map do |k|
        cla = price_series[k..k + period]
        up_ch, down_ch = calculate_channels(cla)

        calculate_smoothing(up_ch, down_ch)
        rsi << (100.00 - (100.00 / ((smooth_up.last.to_f / smooth_down.last) + 1))).round(4)
      end.last
    end
  end
end
