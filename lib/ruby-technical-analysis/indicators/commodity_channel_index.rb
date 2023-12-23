# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Commodity Channel Index indicator
  # Returns a current singular value
  class CommodityChannelIndex
    attr_accessor :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      min_size = (period * 2 - 1)

      highs, lows, closes = price_series.last(min_size).transpose

      typical_prices = highs.zip(closes, lows).map { |h, c, l| (h + c + l) / 3 }
      tp_sma = typical_prices.each_cons(period).map { |tp| RTA::MovingAverages.new(tp).sma(period) }

      period_sum = typical_prices.last(period).sum { |tp| (tp_sma.last - tp).abs }

      ps_next = (period_sum.to_f / period) * 0.015
      tp_sma_min_tp = typical_prices.last(period).last - tp_sma.last

      (tp_sma_min_tp.to_f / ps_next)
    end
  end
end
