module RubyTechnicalAnalysis
  # Williams %R
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/williams-r
  class WilliamsPercentR < Indicator
    attr_reader :period

    # @param price_series [Array] An array of arrays containing high, low, close prices, e.g. [[high, low, close], [high, low, close]]
    # @param period [Integer] The number of periods to use in the calculation, default is 5
    def initialize(price_series, period = 5)
      @period = period
      @highest_highs = []
      @lowest_lows = []
      @highest_highs_minus_close = []
      @highest_highs_minus_lowest_lows = []
      @pct_r = []

      super(price_series)
    end

    # @return [Float] The current Williams %R value
    def call
      calculate_williams_percent_r
    end

    private

    def calculate_lowest_lows(lows, window_start)
      @lowest_lows << lows[window_start..(period - 1 + window_start)].min
    end

    def calculate_highest_highs(highs, window_start)
      @highest_highs << highs[window_start..(period - 1 + window_start)].max
    end

    def calculate_highest_highs_minus_close(closes, window_start)
      @highest_highs_minus_close <<
        (@highest_highs.last - closes.at(period - 1 + window_start)).round(2)
    end

    def calculate_highest_highs_minus_lowest_lows
      @highest_highs_minus_lowest_lows << (@highest_highs.last - @lowest_lows.last).round(4)
    end

    def calculate_pct_r
      @pct_r <<
        ((@highest_highs_minus_close.last.to_f / @highest_highs_minus_lowest_lows.last) * -100).round(2)
    end

    def calculate_williams_percent_r
      highs, lows, closes = extract_highs_lows_closes

      (0..highs.length - period).each do |index|
        calculate_highest_highs(highs, index)
        calculate_lowest_lows(lows, index)
        calculate_highest_highs_minus_close(closes, index)
        calculate_highest_highs_minus_lowest_lows
        calculate_pct_r
      end

      @pct_r.last
    end
  end
end
