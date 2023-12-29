module RubyTechnicalAnalysis
  # Common moving averages used independently or in combination with other indicators
  class MovingAverages
    attr_accessor :price_series

    def initialize(price_series)
      @price_series = price_series
    end

    # Simple Moving Average
    def sma(period)
      price_series.last(period).sum.to_f / period
    end

    # Exponential Moving Average
    def ema(period)
      return price_series.last if period == 1

      case period
      when 12
        last_obs_pct = 0.846154
        ma_pct = 0.153846
      when 26
        last_obs_pct = 0.925926
        ma_pct = 0.074074
      else
        last_obs_pct = 2.0 / (period + 1)
        ma_pct = 1.0 - last_obs_pct
      end

      ma_array = price_series.last(period).each_with_object([]) do |num, result|
        result << if result.empty?
                    num
                  else
                    (num * last_obs_pct) + (result.last * ma_pct)
                  end
      end

      ma_array.last
    end

    # Weighted Moving Average
    def wma(period)
      true_periods = (1..period).sum

      sigma_periods = price_series.last(period).each_with_index.sum { |num, i| (i + 1) * num }

      sigma_periods.to_f / true_periods
    end
  end
end
