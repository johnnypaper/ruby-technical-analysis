module RubyTechnicalAnalysis
  # Statistical Methods
  class StatisticalMethods < Indicator
    # @param price_series [Array] An array of prices, typically closing prices
    # def initialize(price_series)
    #  super(price_series)
    # end

    # Mean
    # @return [Float] The mean of the price series
    def mean
      price_series.reduce(:+) / price_series.length.to_f
    end

    # Standard Deviation
    # @return [Float] The standard deviation of the price series
    def standard_deviation
      return 0 if price_series.uniq.length == 1

      Math.sqrt(variance)
    end

    # Variance
    # @return [Float] The variance of the price series
    def variance
      squared_differences.reduce(:+) / price_series.length.to_f
    end

    private

    def squared_differences
      price_series.map { |value| (value - mean)**2 }
    end
  end
end
