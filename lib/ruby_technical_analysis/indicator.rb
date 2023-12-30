module RubyTechnicalAnalysis
  # Base class for indicators
  class Indicator
    attr_reader :price_series

    def self.call(*args)
      new(*args).call
    end

    def initialize(price_series)
      @price_series = price_series
    end

    private
    
    def extract_series(subset_length = nil)
      subset_length ? price_series.last(subset_length) : price_series
    end

    def extract_highs_lows_closes_volumes(subset_length = nil)
      highs, lows, closes, volumes = extract_series(subset_length).transpose

      [highs, lows, closes, volumes]
    end

    def extract_highs_lows_closes(subset_length = nil)
      highs, lows, closes = extract_series(subset_length).transpose

      [highs, lows, closes]
    end

    def moving_averages(subset_length = nil)
      RubyTechnicalAnalysis::MovingAverages.new(extract_series(subset_length))
    end

    def statistical_methods(subset_length = nil)
      RubyTechnicalAnalysis::StatisticalMethods.new(extract_series(subset_length))
    end
  end
end
