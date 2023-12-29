# frozen_string_literal: true

require_relative "indicator"

module RTA
  # Stochastic Oscillator indicator
  # Returns a single value
  class StochasticOscillator < Indicator
    attr_accessor :lowest_lows, :highest_highs, :close_minus_lowest_lows, :highest_highs_minus_lowest_lows,
                  :ks_sums_close_minus_lowest_lows, :ks_sums_highest_highs_minus_lowest_lows,
                  :ks_sums_quotients_times_100, :d_periods_sma

    attr_reader :k_periods, :k_slow_periods, :d_periods

    def initialize(price_series, k_periods, k_slow_periods, d_periods)
      @k_periods = k_periods
      @k_slow_periods = k_slow_periods
      @d_periods = d_periods
      @lowest_lows = []
      @highest_highs = []
      @close_minus_lowest_lows = []
      @highest_highs_minus_lowest_lows = []
      @ks_sums_close_minus_lowest_lows = []
      @ks_sums_highest_highs_minus_lowest_lows = []
      @ks_sums_quotients_times_100 = []
      @d_periods_sma = []

      super(price_series)
    end

    def call
      calculate_stochastic_oscillator
    end

    private

    def calculate_lowest_lows(lows, window_start)
      lowest_lows << lows[window_start..(window_start + k_periods - 1)].min
    end

    def calculate_highest_highs(highs, window_start)
      highest_highs << highs[window_start..(window_start + k_periods - 1)].max
    end

    def calculate_close_minus_lowest_lows(closes, window_start)
      close_minus_lowest_lows <<
        (closes.at(window_start + k_periods - 1) - lowest_lows.last).round(4)
    end

    def calculate_highest_highs_minus_lowest_lows
      highest_highs_minus_lowest_lows << (highest_highs.last - lowest_lows.last).round(4)
    end

    def calculate_ks_sums_close_minus_lowest_lows
      ks_sums_close_minus_lowest_lows <<
        close_minus_lowest_lows.last(k_slow_periods).sum.round(4)
    end

    def calculate_ks_sums_highest_highs_minus_lowest_lows
      ks_sums_highest_highs_minus_lowest_lows <<
        highest_highs_minus_lowest_lows.last(k_slow_periods).sum.round(4)
    end

    def calculate_ks_sums_quotients_times_100
      ks_sums_quotients_times_100 <<
        ((ks_sums_close_minus_lowest_lows.last.to_f / ks_sums_highest_highs_minus_lowest_lows.last) * 100).round(4)
    end

    def caculate_d_periods_sma
      d_periods_sma << if ks_sums_quotients_times_100.length >= d_periods
                         (ks_sums_quotients_times_100.last(d_periods).sum.to_f / d_periods).round(4)
                       else
                         -1000
                       end
    end

    def calculate_stochastic_oscillator
      highs, lows, closes = extract_highs_lows_closes

      (0..(highs.length - k_periods)).flat_map do |i|
        calculate_lowest_lows(lows, i)
        calculate_highest_highs(highs, i)
        calculate_close_minus_lowest_lows(closes, i)
        calculate_highest_highs_minus_lowest_lows

        if close_minus_lowest_lows.length >= k_slow_periods
          calculate_ks_sums_close_minus_lowest_lows
          calculate_ks_sums_highest_highs_minus_lowest_lows
          calculate_ks_sums_quotients_times_100
        end

        caculate_d_periods_sma
      end.last
    end
  end
end
