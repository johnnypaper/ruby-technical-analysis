# frozen_string_literal: true

# Stochastic Oscillator indicator
# Returns a single value
module StochasticOscillator
  def stochastic_oscillator(k_periods, k_slow_periods, d_periods)
    highs = []
    lows = []
    closes = []

    each do |i|
      highs << i[0]
      lows << i[1]
      closes << i[2]
    end

    if highs.size < k_periods
      raise ArgumentError,
            "High array passed to Stochastic Oscillator cannot be less than the k_periods argument."
    end

    if lows.size < k_periods
      raise ArgumentError,
            "Low array passed to Stochastic Oscillator cannot be less than the k_periods argument."
    end

    if closes.size < k_periods
      raise ArgumentError,
            "Close array passed to Stochastic Oscillator cannot be less than the k_periods argument."
    end

    lowest_lows = []
    highest_highs = []
    close_minus_ll = []
    hh_minus_ll = []

    ks_sums_close_min_ll = []
    ks_sums_hh_min_ll = []
    ks_div_x_100 = []
    d_periods_sma = []

    (0..(highs.length - k_periods)).each do |i|
      lowest_lows << lows[i..(i + k_periods - 1)].min
      highest_highs << highs[i..(i + k_periods - 1)].max
      close_minus_ll << (closes[i + k_periods - 1] - lowest_lows.last).round(4)
      hh_minus_ll << (highest_highs.last - lowest_lows.last).round(4)
      if close_minus_ll.length >= k_slow_periods
        ks_sums_close_min_ll << close_minus_ll.last(k_slow_periods).inject(:+).round(4)
        ks_sums_hh_min_ll << hh_minus_ll.last(k_slow_periods).inject(:+).round(4)
        ks_div_x_100 << ((ks_sums_close_min_ll.last.to_f / ks_sums_hh_min_ll.last) * 100).round(4)
      end
      d_periods_sma << if ks_div_x_100.length >= d_periods
                         (ks_div_x_100.last(d_periods).reduce(:+).to_f / d_periods).round(4)
                       else
                         -1000
                       end
    end

    d_periods_sma[-1]
  end
end

class Array
  include StochasticOscillator
end
