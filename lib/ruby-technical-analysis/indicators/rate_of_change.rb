# frozen_string_literal: true

require_relative "indicator"

module RTA
  # RateOfChange indicator
  # Returns a single value
  class RateOfChange < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

    def call
      calculate_roc
    end

    private

    def calculate_roc
      (((price_series.last - price_series.last(period + 1).first).to_f / price_series.last(period + 1).first) * 100).round(2) # rubocop:disable Layout/LineLength
    end
  end
end
