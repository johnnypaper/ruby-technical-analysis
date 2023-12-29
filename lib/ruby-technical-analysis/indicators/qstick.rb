# frozen_string_literal: true

require_relative "indicator"

module RTA
  # Qstick indicator
  # Returns a single value
  class QStick < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

    def call
      calculate_qstick
    end

    private

    def _opens
      @_opens ||= price_series.last(period).map { |i| i.at(0) }
    end

    def _closes
      @_closes ||= price_series.last(period).map { |i| i.at(1) }
    end

    def cmo_sum
      _closes.zip(_opens).sum { |close, open| close - open }
    end

    def calculate_qstick
      (cmo_sum.to_f / period).round(4)
    end
  end
end
