# frozen_string_literal: true

# module MovingAverages contains some common moving averages and those used in other technical functions
# it is built upon the array class and all methods assume the use of an array
module MovingAverages
  # Simple Moving Average
  def sma(period)
    if period <= 0
      raise ArgumentError,
            "The period parameter cannot be less than 1."
    end

    if size < period
      raise ArgumentError,
            "The array size is less than the period size for the simple moving average."
    end

    (last(period).reduce(:+).to_f / period)
  end

  # Exponential Moving Average
  def ema(period)
    if period < 1
      raise ArgumentError,
            "The period parameter cannot be less than 1."
    end
    if size < period
      raise ArgumentError,
            "The array size is less than the period size for the exponential moving average."
    end

    if period == 1
      last
    else
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

      ma_array = []

      last(period).each_with_index do |num, i|
        ma_array << if i.zero?
                      num
                    else
                      (num * last_obs_pct) + (ma_array[i - 1] * ma_pct)
                    end
      end

      ma_array.last
    end
  end

  # Weighted Moving Average
  def wma(period)
    if period <= 0 || size < period
      raise ArgumentError,
            "The period of the weighted moving average supplied must be greater than 0 and less than or equal to the
            size of the array."
    end

    true_periods = 0
    (1..period).each do |i|
      true_periods += i
    end

    sigma_periods = 0.0
    last(period).each_with_index do |num, i|
      sigma_periods += ((i + 1) * num)
    end

    (sigma_periods.to_f / true_periods)
  end
end

class Array
  include MovingAverages
end
