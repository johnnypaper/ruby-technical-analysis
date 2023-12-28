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
      calculate_cmo
    end

    private

    def _closes
      @_closes ||= extract_series(period + 1)
    end

    def calculate_change_sums
      (1..period).each do |i|
        price_diff = _closes.at(i) - _closes.at(i - 1)
        self.up_change_sum += price_diff if price_diff.positive?
        self.down_change_sum -= price_diff if price_diff.negative?
      end

      up_change_sum + down_change_sum
    end

    def _up_sum_plus_down_sum
      @_up_sum_plus_down_sum ||= calculate_change_sums
    end

    def calculate_oscillator_value
      (up_change_sum - down_change_sum).to_f / _up_sum_plus_down_sum * 100
    end

    def calculate_cmo
      _up_sum_plus_down_sum.zero? ? 0 : calculate_oscillator_value.round(4)
    end
  end
end
