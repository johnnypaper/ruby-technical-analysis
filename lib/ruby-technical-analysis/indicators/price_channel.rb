# frozen_string_literal: true

# Price Channel indicator
# Returns an array containing the current upper and lower values of the series
module PriceChannel
  def price_channel(period)
    highs = []
    lows = []

    each do |i|
      highs << i[0]
      lows << i[1]
    end

    if highs.size < period + 1
      raise ArgumentError,
            "The highs array size is less than the period + 1 size required."
    end

    if lows.size < period + 1
      raise ArgumentError,
            "The lows array size is less than the period + 1 size required."
    end

    highs = highs.last(period + 1)
    lows = lows.last(period + 1)

    upper_pc = (highs[0..period - 1]).max
    lower_pc = (lows[0..period - 1]).min

    [upper_pc, lower_pc]
  end
end

class Array
  include PriceChannel
end
