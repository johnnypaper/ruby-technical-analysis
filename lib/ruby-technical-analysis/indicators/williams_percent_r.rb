# frozen_string_literal: true

# Williams Percent R indicator
# Returns a single value
module WilliamsPercentR
  def williams_percent_r(period)

    highs = []
    lows = []
    closes = []

    each do |i|
      highs << i[0]
      lows << i[1]
      closes << i[2]
    end

    if highs.size < period
      raise ArgumentError,
            "High array passed to Williams Percent R cannot be less than the period argument."
    end

    if lows.size < period
      raise ArgumentError,
            "Low array passed to Williams Percent R cannot be less than the period argument."
    end

    if closes.size < period
      raise ArgumentError,
            "Close array passed to Williams Percent R cannot be less than the period argument."
    end

    highest_highs = []
    lowest_lows = []
    hh_min_close = []
    hh_min_ll = []
    pct_r = []

    (0..highs.length - period).each do |i|
      highest_highs << highs[i..period - 1 + i].max
      lowest_lows << lows[i..period - 1 + i].min
      hh_min_close << (highest_highs[-1] - closes[period - 1 + i]).round(2)
      hh_min_ll << (highest_highs[-1] - lowest_lows[-1]).round(2)
      pct_r << ((hh_min_close[-1].to_f / hh_min_ll[-1]) * -100).round(2)
    end

    pct_r[-1]
  end
end

class Array
  include WilliamsPercentR
end
