# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

# Mass Index indicator
# Returns a singular current value
module MassIndex
  def mass_index(period)
    highs = []
    lows = []

    each do |i|
      highs << i[0]
      lows << i[1]
    end

    if highs.size < period
      raise ArgumentError,
            "High array passed to Mass Index cannot be less than (2 * period + 1)."
    end

    if lows.size < period
      raise ArgumentError,
            "Low array passed to Mass Index cannot be less than (2 * period + 1)."
    end

    full_period = (2 * period + 1)
    highs = highs.last(full_period)
    lows = lows.last(full_period)

    hml_arr = []
    hml_ema_arr = []
    hml_ema_ema_arr = []

    (0..(highs.size - 1)).each do |i|
      hml_arr << highs[i] - lows[i]
    end

    low_multiple = (2.0 / (period + 1)).truncate(4)
    high_multiple = 1 - low_multiple

    (0..hml_arr.length - 1).each do |i|
      hml_ema_arr << if i.zero?
                       hml_arr[0].truncate(4)
                     else
                       ((hml_arr[i] * low_multiple) + (hml_ema_arr[i - 1] * high_multiple)).truncate(4)
                     end
    end

    (0..period + 1).each do |i|
      hml_ema_ema_arr << if i.zero?
                           hml_ema_arr[period - i - 1]
                         else
                           ((hml_ema_arr[period + i - 1] * 0.2) + (hml_ema_ema_arr[-1] * 0.8)).round(4)
                         end
    end

    ema_period_two_div_ema_period = []

    mi = 0.0
    (0..2).each do |i|
      ema_period_two_div_ema_period <<
        ((hml_ema_arr[(period * 2) + i - 2]) / (hml_ema_ema_arr[period + i - 1])).round(4)
      mi += ((hml_ema_arr[(period * 2) + i - 2]) / (hml_ema_ema_arr[period + i - 1])).round(4)
    end

    mi.round(4)
  end
end

class Array
  include MassIndex
end
