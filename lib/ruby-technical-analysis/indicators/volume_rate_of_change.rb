# frozen_string_literal: true

# Volume Rate of Change indicator
# Returns a single value
module VolumeRateOfChange
  def volume_rate_of_change(period)
    if size < (period + 1)
      raise ArgumentError,
            "Volumes array passed to Volume Rate of Change cannot be less than period parameter + 1."
    end

    delta_volume = []
    vol_shifted = []

    (0..(length - period - 1)).each do
      vol_shifted << at(length - period - 1)
      delta_volume << at(-1) - vol_shifted[-1]
    end

    ((delta_volume[-1].to_f / vol_shifted[-1]) * 100).round(4)
  end
end

class Array
  include VolumeRateOfChange
end
