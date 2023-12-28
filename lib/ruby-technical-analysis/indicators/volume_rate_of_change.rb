# frozen_string_literal: true

module RTA
  # Volume Rate of Change indicator
  # Returns a single value
  class VolumeRateOfChange
    attr_accessor :delta_volume, :vol_shifted
    attr_reader :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
      @delta_volume = []
      @vol_shifted = []
    end

    def call
      _iterations.times do
        calculate_vol_shifted
        delta_volume << price_series.last - vol_shifted.last
      end

      ((delta_volume.last.to_f / vol_shifted.last) * 100).round(4)
    end

    private

    def _iterations
      @_iterations ||= price_series.length - period
    end

    def calculate_vol_shifted
      vol_shifted << price_series.at(_iterations - 1)
    end
  end
end
