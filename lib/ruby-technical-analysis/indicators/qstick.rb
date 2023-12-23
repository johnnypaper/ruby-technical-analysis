# frozen_string_literal: true

module RTA
  # Qstick indicator
  # Returns a single value
  class QStick
    attr_reader :price_series, :period

    def initialize(price_series, period)
      @price_series = price_series
      @period = period
    end

    def call
      (cmo_sum.to_f / period).round(4)
    end

    private

    def _opens
      @_opens ||= price_series.map { |i| i[0] }.last(period)
    end

    def _closes
      @_closes ||= price_series.map { |i| i[1] }.last(period)
    end

    def cmo_sum
      _closes.first(period).zip(_opens.first(period)).sum { |close, open| close - open }
    end
  end
end
