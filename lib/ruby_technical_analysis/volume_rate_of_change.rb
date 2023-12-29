module RubyTechnicalAnalysis
  # Volume Rate of Change indicator
  # Returns a single value
  class VolumeRateOfChange < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

    def call
      calculate_volume_rate_of_change
    end

    private

    def _calculable_series_length
      @_calculable_series_length ||= price_series.length - period
    end

    def _vol_shifted
      @_vol_shifted ||= _calculable_series_length.times.map do
        price_series.at(_calculable_series_length - 1)
      end
    end

    def delta_volume
      _calculable_series_length.times.map do
        price_series.last - _vol_shifted.last
      end
    end

    def calculate_volume_rate_of_change
      ((delta_volume.last.to_f / _vol_shifted.last) * 100).round(4)
    end
  end
end
