# frozen_string_literal: true

require_relative "wilders_smoothing"

# Relative Momentum Index indicator
# Returns a single value
module RelativeStrengthIndex
  def rsi(period)
    if size < (period + 1)
      raise ArgumentError,
            "Closes array passed to Relative Strength Index cannot be less than the period + 1 argument."
    end

    rsi = []
    wilders_is_set = false
    smooth_up = []
    smooth_down = []

    smooth_coef_one = (1.0 / period).round(4)
    smooth_coef_two = (1 - smooth_coef_one)

    (0..(size - period - 1)).each do |k|
      cla = self[k..k + period]

      up_ch = []
      down_ch = []

      (1..period).each do |i|
        cur_close = cla[i]
        prev_close = cla[i - 1]
        close_diff = cur_close - prev_close

        if close_diff > 0.00
          up_ch << close_diff
          down_ch << 0.00
        elsif close_diff < 0.00
          up_ch << 0.00
          down_ch << close_diff.abs
        else
          up_ch << 0.00
          down_ch << 0.00
        end
      end

      if wilders_is_set
        smooth_up << (smooth_coef_one * up_ch[-1] + smooth_coef_two * smooth_up[-1]).round(4)
        smooth_down << (smooth_coef_one * down_ch[-1] + smooth_coef_two * smooth_down[-1]).round(4)
      else
        smooth_up << up_ch.last(period).wilders_smoothing(period)
        smooth_down << down_ch.last(period).wilders_smoothing(period)
        wilders_is_set = true
      end

      rsi << (100.00 - (100.00 / ((smooth_up[-1].to_f / smooth_down[-1]) + 1))).round(4)
    end

    rsi[-1]
  end
end

class Array
  include RelativeStrengthIndex
end
