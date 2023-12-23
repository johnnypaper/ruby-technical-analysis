# frozen_string_literal: true

module RTA
  # Chaikin Money Flow indicator
  # Returns a current singular value
  class ChandeMomentumOscillator
    attr_accessor :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      closes = price_series.last(period + 1)

      up_change_sum = 0
      down_change_sum = 0

      (1..period).each do |i|
        price_diff = closes[i] - closes[i - 1]
        up_change_sum += price_diff if price_diff.positive?
        down_change_sum -= price_diff if price_diff.negative?
      end

      up_sum_plus_down_sum = up_change_sum + down_change_sum

      oscillator_value = if up_sum_plus_down_sum.zero?
                           0
                         else
                           (up_change_sum - down_change_sum).to_f / up_sum_plus_down_sum * 100
                         end

      oscillator_value.round(4)
    end
  end
end
