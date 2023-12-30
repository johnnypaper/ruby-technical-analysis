module RubyTechnicalAnalysis
  # Volume Rate of Change
  #
  # Find more information at: https://www.investopedia.com/articles/technical/02/091002.asp
  class VolumeRateOfChange < Indicator
    attr_reader :period

    # @param price_series [Array] An array of volume values
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(price_series, period = 25)
      @period = period

      super(price_series)
    end

    # @return [Float] The current volume rate of change value
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
