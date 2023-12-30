module RubyTechnicalAnalysis
  # Common moving averages used independently or in combination with other indicators
  class MovingAverages < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

    # Simple Moving Average
    def sma
      price_series.last(period).sum.to_f / period
    end

    # Exponential Moving Average
    def ema
      return price_series.last if period == 1

      price_series.last(period).each_with_object([]) do |num, result|
        result << if result.empty?
          num
        else
          (num * _ema_percentages.first) + (result.last * _ema_percentages.last)
        end
      end.last
    end

    # Weighted Moving Average
    def wma
      true_periods = (1..period).sum

      sigma_periods = price_series.last(period).each_with_index.sum { |num, index| (index + 1) * num }

      sigma_periods.to_f / true_periods
    end

    private

    def _ema_percentages
      @_ema_percentages ||=
        case period
        when 12 then [0.846154, 0.153846]
        when 26 then [0.925926, 0.074074]
        else
          last_obs_pct = 2.0 / (period + 1)

          [last_obs_pct, 1 - last_obs_pct]
        end
    end
  end
end
