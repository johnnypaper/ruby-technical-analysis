# frozen_string_literal: true

require_relative "indicator"
require_relative "wilders_smoothing"

module RTA
  # Relative Momentum Index indicator
  # Returns a single value
  class RelativeMomentumIndex < Indicator
    attr_accessor :wilders_is_set, :rmi, :rmi_intermediate, :smooth_up, :smooth_down
    attr_reader :period_mom, :period_rmi

    def initialize(price_series, period_mom, period_rmi)
      @period_mom = period_mom
      @period_rmi = period_rmi
      @rmi = []
      @rmi_intermediate = []
      @smooth_up = []
      @smooth_down = []
      @wilders_is_set = false

      super(price_series)
    end

    def call
      calculate_rmi
    end

    private

    def _pmpr
      @_pmpr ||= (period_mom + period_rmi)
    end

    def _smooth_coef_one
      @_smooth_coef_one ||= (1.0 / period_rmi).round(4)
    end

    def _smooth_coef_two
      @_smooth_coef_two ||= (1 - _smooth_coef_one)
    end

    def calculate_channels(cla)
      period_rmi.times.map do |i|
        diff = (cla.at(i) - cla.at(period_mom + i)).round(4)

        [diff.negative? ? diff.abs : 0, diff.positive? ? diff : 0]
      end.transpose
    end

    def calculate_initial_smoothing(up_ch, down_ch)
      smooth_up << RTA::WildersSmoothing.new(up_ch, period_rmi).call
      smooth_down << RTA::WildersSmoothing.new(down_ch, period_rmi).call
      self.wilders_is_set = true
    end

    def calculate_subsequent_smoothing(up_ch, down_ch)
      smooth_up << (_smooth_coef_one * up_ch.last + _smooth_coef_two * smooth_up.last).round(4)
      smooth_down << (_smooth_coef_one * down_ch.last + _smooth_coef_two * smooth_down.last).round(4)
    end

    def calculate_smoothing(up_ch, down_ch)
      wilders_is_set ? calculate_subsequent_smoothing(up_ch, down_ch) : calculate_initial_smoothing(up_ch, down_ch)
    end

    def calculate_rmi
      (0..(price_series.size - _pmpr)).flat_map do |i|
        cla = price_series[i..(i + _pmpr - 1)]
        up_ch, down_ch = calculate_channels(cla)

        calculate_smoothing(up_ch, down_ch)

        rmi_intermediate << (smooth_up.last.to_f / smooth_down.last)
        rmi << ((rmi_intermediate.last.to_f / (1 + rmi_intermediate.last)) * 100).round(4)
      end.last
    end
  end
end
