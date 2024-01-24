module RubyTechnicalAnalysis
  # Stochastic Oscillator
  #
  # Find more information at: https://www.investopedia.com/terms/s/stochasticoscillator.asp
  class StochasticOscillator < Indicator
    attr_reader :k_periods, :k_slow_periods, :d_periods

    # @param series [Array] An array of arrays containing high, low, close prices, e.g. [[high, low, close], [high, low, close]]
    # @param k_periods [Integer] The number of periods to use in the calculation
    # @param k_slow_periods [Integer] The number of periods to use in the calculation
    # @param d_periods [Integer] The number of periods to use in the calculation
    def initialize(series: [], k_periods: 14, k_slow_periods: 3, d_periods: 3)
      @k_periods = k_periods
      @k_slow_periods = k_slow_periods
      @d_periods = d_periods
      @lowest_lows = []
      @highest_highs = []
      @close_minus_lowest_lows = []
      @highest_highs_minus_lowest_lows = []
      @ks_sums_close_minus_lowest_lows = []
      @ks_sums_highest_highs_minus_lowest_lows = []
      @ks_sums_quotients_times_one_hundred = []
      @d_periods_sma = []

      super(series: series)
    end

    # @return [Float] The current Stochastic Oscillator value
    def call
      calculate_stochastic_oscillator
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      k_periods + d_periods <= series.length
    end

    private

    def calculate_lowest_lows(lows, window_start)
      @lowest_lows << lows[window_start..(window_start + k_periods - 1)].min
    end

    def calculate_highest_highs(highs, window_start)
      @highest_highs << highs[window_start..(window_start + k_periods - 1)].max
    end

    def calculate_close_minus_lowest_lows(closes, window_start)
      @close_minus_lowest_lows <<
        (closes.at(window_start + k_periods - 1) - @lowest_lows.last).round(4)
    end

    def calculate_highest_highs_minus_lowest_lows
      @highest_highs_minus_lowest_lows << (@highest_highs.last - @lowest_lows.last).round(4)
    end

    def calculate_ks_sums_close_minus_lowest_lows
      @ks_sums_close_minus_lowest_lows <<
        @close_minus_lowest_lows.last(k_slow_periods).sum.round(4)
    end

    def calculate_ks_sums_highest_highs_minus_lowest_lows
      @ks_sums_highest_highs_minus_lowest_lows <<
        @highest_highs_minus_lowest_lows.last(k_slow_periods).sum.round(4)
    end

    def calculate_ks_sums_quotients_times_one_hundred
      @ks_sums_quotients_times_one_hundred <<
        ((@ks_sums_close_minus_lowest_lows.last.to_f / @ks_sums_highest_highs_minus_lowest_lows.last) * 100).round(4)
    end

    def caculate_d_periods_sma
      @d_periods_sma << if @ks_sums_quotients_times_one_hundred.length >= d_periods
        (@ks_sums_quotients_times_one_hundred.last(d_periods).sum.to_f / d_periods).round(4)
      else
        -1000
      end
    end

    def calculate_stochastic_oscillator
      highs, lows, closes = extract_highs_lows_closes

      (0..(highs.length - k_periods)).flat_map do |index|
        calculate_lowest_lows(lows, index)
        calculate_highest_highs(highs, index)
        calculate_close_minus_lowest_lows(closes, index)
        calculate_highest_highs_minus_lowest_lows

        if @close_minus_lowest_lows.length >= k_slow_periods
          calculate_ks_sums_close_minus_lowest_lows
          calculate_ks_sums_highest_highs_minus_lowest_lows
          calculate_ks_sums_quotients_times_one_hundred
        end

        caculate_d_periods_sma
      end.last
    end
  end
end
