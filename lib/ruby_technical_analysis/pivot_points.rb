module RubyTechnicalAnalysis
  # Pivot Points indicator
  # Returns an array of the current pivot points for the provided H, L, C array
  class PivotPoints < Indicator
    def call
      calculate_pivot_points
    end

    private

    def _high
      @_high ||= price_series.first
    end

    def _low
      @_low ||= price_series.at(1)
    end

    def _close
      @_close ||= price_series.last
    end

    def _pivot
      @_pivot ||= ((_high + _low + _close) / 3.0).round(2)
    end

    def support_1
      ((2 * _pivot) - _high).round(2)
    end

    def support_2
      (_pivot - (_high - _low)).round(2)
    end

    def support_3
      (_low - (2 * (_high - _pivot))).round(2)
    end

    def resistance_1
      ((2 * _pivot) - _low).round(2)
    end

    def resistance_2
      (_pivot + (_high - _low)).round(2)
    end

    def resistance_3
      (_high + (2 * (_pivot - _low))).round(2)
    end

    def calculate_pivot_points
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
  end
end
