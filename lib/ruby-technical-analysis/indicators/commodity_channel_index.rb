# frozen_string_literal: true

require_relative "indicator"
require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Commodity Channel Index indicator
  # Returns a current singular value
  class CommodityChannelIndex < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

    def call
      calculate_cci
    end

    private

    def min_size
      (period * 2 - 1)
    end

    def calculate_typical_prices
      highs, lows, closes = extract_highs_lows_closes(min_size)

      highs.zip(closes, lows).map { |h, c, l| (h + c + l) / 3 }
    end

    def _typical_prices
      @_typical_prices ||= calculate_typical_prices
    end

    def calculate_typical_prices_sma
      _typical_prices.each_cons(period).map do |tp|
        RTA::MovingAverages.new(tp).sma(period)
      end
    end

    def _typical_prices_sma
      @_typical_prices_sma ||= calculate_typical_prices_sma
    end

    def calculate_period_sum
      _typical_prices.last(period).sum { |tp| (_typical_prices_sma.last - tp).abs }
    end

    def _period_sum
      @_period_sum ||= calculate_period_sum
    end

    def calculate_period_sum_next_period
      (_period_sum.to_f / period) * 0.015
    end

    def _period_sum_next_period
      @_period_sum_next_period ||= calculate_period_sum_next_period
    end

    def calculate_typical_prices_sma_minus_typical_prices
      _typical_prices.last(period).last - _typical_prices_sma.last
    end

    def _typical_prices_sma_minus_typical_prices
      @_typical_prices_sma_minus_typical_prices ||=
        calculate_typical_prices_sma_minus_typical_prices
    end

    def calculate_cci
      (_typical_prices_sma_minus_typical_prices.to_f / _period_sum_next_period)
    end
  end
end
