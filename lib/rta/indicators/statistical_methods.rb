module Rta
  # Statistical Methods
  class StatisticalMethods < Indicator
    # @param series [Array] An array of prices, typically closing prices
    # def initialize(series: [])
    #  super(series: series)
    # end

    # Mean
    # @return [Float] The mean of the price series
    def mean
      series.reduce(:+) / series.length.to_f
    end

    # Standard Deviation
    # @return [Float] The standard deviation of the price series
    def standard_deviation
      return 0 if series.uniq.length == 1

      Math.sqrt(variance)
    end

    # Variance
    # @return [Float] The variance of the price series
    def variance
      squared_differences.reduce(:+) / series.length.to_f
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      series.length > 0
    end

    private

    def squared_differences
      series.map { |value| (value - mean)**2 }
    end
  end
end
