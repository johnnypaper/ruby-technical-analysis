# frozen_string_literal: true

module RTA
  # Pivot Points indicator
  # Returns an array of the current pivot points for the provided H, L, C array
  class PivotPoints
    attr_reader :high, :low, :close

    def initialize(hlc_array)
      @high = hlc_array[0]
      @low = hlc_array[1]
      @close = hlc_array[2]
    end

    def call
      [
        support_3,
        support_2,
        support_1,
        _pivot,
        resistance_1,
        resistance_2,
        resistance_3
      ]
    end

    private

    def _pivot
      @_pivot ||= ((high + low + close) / 3.0).round(2)
    end

    def support_1
      ((2 * _pivot) - high).round(2)
    end

    def support_2
      (_pivot - (high - low)).round(2)
    end

    def support_3
      (low - (2 * (high - _pivot))).round(2)
    end

    def resistance_1
      ((2 * _pivot) - low).round(2)
    end

    def resistance_2
      (_pivot + (high - low)).round(2)
    end

    def resistance_3
      (high + (2 * (_pivot - low))).round(2)
    end
  end
end
