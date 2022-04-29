# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

# Commodity Channel Index indicator
# Returns a current singular value
module CommodityChannelIndex
  def commodity_channel_index(period)
    min_size = ((period * 2) - 1)

    highs = []
    lows = []
    closes = []

    each do |h, l, c|
      highs << h
      lows << l
      closes << c
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

    highs = highs.last(min_size)
    lows = lows.last(min_size)
    closes = closes.last(min_size)

    typical_prices = []
    tp_sma = []
    period_sum = 0

    (0..(min_size - 1)).each do |i|
      typical_prices << (highs[i] + closes[i] + lows[i]) / 3
    end

    (0..(period - 1)).each do |i|
      tp_sma << typical_prices[i..(i + period - 1)].sma(period)
    end

    typical_prices.last(period).each do |tp|
      period_sum += (tp_sma[-1] - tp).abs
    end

    ps_next = (period_sum.to_f / period) * 0.015
    tp_sma_min_tp = typical_prices[-1] - tp_sma[-1]
    (tp_sma_min_tp.to_f / ps_next)
  end
end

class Array
  include CommodityChannelIndex
end
