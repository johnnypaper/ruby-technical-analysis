# frozen_string_literal: true

# Chaikin Money Flow indicator
# Returns a current singular value
module ChaikinMoneyFlow
  def chaikin_money_flow(period)
    highs = []
    lows = []
    closes = []
    volumes = []

    each do |h, l, c, v|
      highs << h
      lows << l
      closes << c
      volumes << v
    end

    if highs.size < period
      raise ArgumentError,
            "High array passed to Chaikin Money Flow cannot be less than the period argument."
    end

    if lows.size < period
      raise ArgumentError,
            "Low array passed to Chaikin Money Flow cannot be less than the period argument."
    end

    if closes.size < period
      raise ArgumentError,
            "Close array passed to Chaikin Money Flow cannot be less than the period argument."
    end

    if volumes.size < period
      raise ArgumentError,
            "Volume array passed to Chaikin Money Flow cannot be less than the period argument."
    end

    if size < period
      raise ArgumentError,
            "Array passed to Bollinger Bands cannot be less than the period argument."
    end

    highs = highs.last(period)
    lows = lows.last(period)
    closes = closes.last(period)
    volumes = volumes.last(period)

    num_sum = 0
    vol_sum = 0

    (0..(period - 1)).each do |i|
      vol_sum += volumes[i]

      cml = closes[i] - lows[i]
      hmc = highs[i] - closes[i]
      hml = highs[i] - lows[i]

      num_sum += ((cml - hmc).to_f / hml) * volumes[i]
    end

    cmf = num_sum.to_f / vol_sum

    cmf.round(5)
  end
end

class Array
  include ChaikinMoneyFlow
end
