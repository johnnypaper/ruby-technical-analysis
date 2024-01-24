module RubyTechnicalAnalysis
  # Base class for indicators
  class Indicator
    attr_reader :series

    def self.call(**kwargs) # standard:disable Style/ArgumentsForwarding
      new(**kwargs).call # standard:disable Style/ArgumentsForwarding
    end

    # @param series [Array] An array of prices
    def initialize(series: [])
      @series = series
    end

    private

    def extract_series(subset_length: nil)
      subset_length.nil? ? series : series.last(subset_length)
    end

    def extract_highs_lows_closes_volumes(subset_length: nil)
      highs, lows, closes, volumes = extract_series(subset_length: subset_length).transpose

      [highs, lows, closes, volumes]
    end

    def extract_highs_lows_closes(subset_length: nil)
      highs, lows, closes = extract_series(subset_length: subset_length).transpose

      [highs, lows, closes]
    end

    def moving_averages(subset_length: nil, period: nil)
      RubyTechnicalAnalysis::MovingAverages.new(series: extract_series(subset_length: subset_length), period: period)
    end

    def statistical_methods(subset_length: nil)
      RubyTechnicalAnalysis::StatisticalMethods.new(series: extract_series(subset_length: subset_length))
    end
  end
end
