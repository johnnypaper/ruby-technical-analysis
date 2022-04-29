# frozen_string_literal: true

require_relative "wilders_smoothing"

# Relative Momentum Index indicator
# Returns a single value
module RelativeMomentumIndex
  def relative_momentum_index(period_mom, period_rmi)
    pmpr = period_mom + period_rmi

    if size < pmpr
      raise ArgumentError,
            "Closes array passed to Relative Momentum Index cannot be less than the period mom + period rmi arguments."
    end

    rmi = []
    rmi_intermediate = []
    wilders_is_set = false
    smooth_up = []
    smooth_down = []

    smooth_coef_one = (1.0 / period_rmi).round(4)
    smooth_coef_two = (1 - smooth_coef_one)

    (0..(size - pmpr)).each do |i|
      cla = self[i..(i + pmpr - 1)]
      up_ch = []
      down_ch = []

      (0..period_rmi - 1).each do |m|
        cur_close = cla[m]
        prev_close = cla[period_mom + m]
        diff = (cur_close - prev_close).round(4)

        if diff.negative?
          up_ch << diff.abs
          down_ch << 0.00
        elsif diff.positive?
          up_ch << 0.00
          down_ch << diff
        else
          up_ch << 0.00
          down_ch << 0.00
        end
      end

      if wilders_is_set
        smooth_up << (smooth_coef_one * up_ch[-1] + smooth_coef_two * smooth_up[-1]).round(4)
        smooth_down << (smooth_coef_one * down_ch[-1] + smooth_coef_two * smooth_down[-1]).round(4)
      else
        smooth_up << up_ch.wilders_smoothing(period_rmi)
        smooth_down << down_ch.wilders_smoothing(period_rmi)
        wilders_is_set = true
      end

      rmi_intermediate << (smooth_up[-1].to_f / smooth_down[-1])
      rmi << ((rmi_intermediate[-1].to_f / (1 + rmi_intermediate[-1])) * 100).round(4)
    end

    rmi[-1]
  end
end

class Array
  include RelativeMomentumIndex
end
