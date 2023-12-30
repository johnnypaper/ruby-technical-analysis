module RubyTechnicalAnalysis
  # Chaikin Money Flow
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/cmf
  class ChaikinMoneyFlow < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period
      @cmf_sum = 0
      @vol_sum = 0

      super(price_series)
    end

    def call
      calculate_cmf
    end

    private

    def calculate_cmf_sum
      highs, lows, closes, volumes = extract_highs_lows_closes_volumes(period)

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
