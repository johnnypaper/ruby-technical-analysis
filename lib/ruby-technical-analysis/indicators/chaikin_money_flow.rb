# frozen_string_literal: true

module RTA
  # Chaikin Money Flow indicator
  # Returns a current singular value
  class ChaikinMoneyFlow
    attr_accessor :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      highs = []
      lows = []
      closes = []
      volumes = []

      price_series.last(period).each do |h, l, c, v|
        highs << h
        lows << l
        closes << c
        volumes << v
      end

      num_sum = 0
      vol_sum = 0

      (0..(period - 1)).each do |i|
        vol_sum += volumes[i]

        cml = closes[i] - lows[i]
        hmc = highs[i] - closes[i]
        hml = highs[i] - lows[i]

        num_sum += ((cml - hmc).to_f / hml) * volumes[i]
      end

      cmf = vol_sum.zero? ? 0 : num_sum.to_f / vol_sum
      cmf.round(5)
    end
  end
end
