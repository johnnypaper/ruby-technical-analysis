# frozen_string_literal: true

require_relative "indicator"

module RTA
  # Chaikin Money Flow indicator
  # Returns a current singular value
  class ChandeMomentumOscillator < Indicator
    attr_accessor :up_change_sum, :down_change_sum
    attr_reader :period

    def initialize(price_series, period)
      @period = period
      @up_change_sum = 0
      @down_change_sum = 0

      super(price_series)
    end

    def call
      closes = price_series.last(period + 1)

      (1..period).each do |i|
        price_diff = closes.at(i) - closes.at(i - 1)
        self.up_change_sum += price_diff if price_diff.positive?
        self.down_change_sum -= price_diff if price_diff.negative?
      end

      up_sum_plus_down_sum = up_change_sum + down_change_sum

      up_sum_plus_down_sum.zero? ? 0 : calculate_oscillator_value(up_sum_plus_down_sum).round(4)
    end

    private

    def calculate_oscillator_value(up_sum_plus_down_sum)
      (up_change_sum - down_change_sum).to_f / up_sum_plus_down_sum * 100
    end
  end
end
