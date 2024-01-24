module Rta
  # Chaikin Money Flow
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/cmf
  class ChaikinMoneyFlow < Indicator
    attr_reader :period

    # @param series [Array] An array of arrays containing high, low, close, and volume information, e.g. [[high, low, close, volume], [high, low, close, volume]]
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(series: [], period: 21)
      @period = period
      @cmf_sum = 0
      @vol_sum = 0

      super(series: series)
    end

    # @return [Float] The current Chaikin Money Flow value
    def call
      calculate_cmf
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      period <= series.length
    end

    private

    def calculate_cmf_sum
      highs, lows, closes, volumes = extract_highs_lows_closes_volumes(subset_length: period)

      period.times do |index|
        high, low, close, volume = highs.at(index), lows.at(index), closes.at(index), volumes.at(index)

        @vol_sum += volume
        @cmf_sum += (((close - low) - (high - close)).to_f / (high - low)) * volume
      end
    end

    def calculate_cmf
      calculate_cmf_sum

      (@vol_sum.zero? ? 0 : @cmf_sum.to_f / @vol_sum).round(5)
    end
  end
end
