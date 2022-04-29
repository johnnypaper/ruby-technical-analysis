# frozen_string_literal: true

# RateOfChange indicator
# Returns a single value
module RateOfChange
  def rate_of_change(period)
    if size < (period + 1)
      raise ArgumentError,
            "Closes array passed to RateOfChange cannot be less than the period argument + 1."
    end

    (((self[-1] - last(period + 1)[0]).to_f / last(period + 1)[0]) * 100).round(2)
  end
end

class Array
  include RateOfChange
end
