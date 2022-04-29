# frozen_string_literal: true

# Intraday Momentum Index indicator
# Returns a singular current value
module IntradayMomentumIndex
  def intraday_momentum_index(period)

    opens = []
    closes = []

    each do |o, c|
      opens << o
      closes << c
    end

    if opens.size < period
      raise ArgumentError,
            "Opens array passed to Intraday Momentum Index cannot be less than the period argument."
    end

    if closes.size < period
      raise ArgumentError,
            "Closes array passed to Intraday Momentum Index cannot be less than the period argument."
    end

    closes = closes.last(period)
    opens = opens.last(period)

    gsum = 0.0
    lsum = 0.0

    (0..(period - 1)).each do |i|
      cmo = (closes[i] - opens[i]).abs
      if closes[i] > opens[i]
        gsum += cmo
      else
        lsum += cmo
      end
    end

    gsum_plus_lsum = gsum + lsum

    ((gsum.to_f / gsum_plus_lsum) * 100).round(4)
  end
end

class Array
  include IntradayMomentumIndex
end
