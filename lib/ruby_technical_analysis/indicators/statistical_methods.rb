module RubyTechnicalAnalysis
  # Statistical methods used in calculations
  class StatisticalMethods < Indicator
    def mean
      price_series.reduce(:+) / price_series.length.to_f
    end

    def standard_deviation
      return 0 if price_series.uniq.length == 1

      Math.sqrt(variance)
    end

    def variance
      squared_differences.reduce(:+) / price_series.length.to_f
    end

    private

    def squared_differences
      price_series.map { |value| (value - mean)**2 }
    end
  end
end
