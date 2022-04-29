# frozen_string_literal: true

# Qstick indicator
# Returns a single value
module Qstick
  def qstick(period)
    opens = []
    closes = []

    each do |i|
      opens << i[0]
      closes << i[1]
    end

    if opens.size < period
      raise ArgumentError,
            "Opens array passed to Qstick cannot be less than the period argument."
    end

    if closes.size < period
      raise ArgumentError,
            "Closes array passed to Qstick cannot be less than the period argument."
    end

    opens = opens.last(period)
    closes = closes.last(period)

    cmo_sum = 0.0

    (0..(period - 1)).each do |i|
      cmo_sum += closes[i] - opens[i]
    end

    (cmo_sum.to_f / period).round(4)
  end
end

class Array
  include Qstick
end
