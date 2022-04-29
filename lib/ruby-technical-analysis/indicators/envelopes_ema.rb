# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

# Envelopes EMA indicator
# Returns an array of current high, middle and low eema values
module EnvelopesEma
  def envelopes_ema(period, percent)
    if size < period
      raise ArgumentError,
            "Close array passed to Envelopes EMA cannot be less than the period argument."
    end

    eema = last(period).ema(period)
    eema_up = (eema.round(3) * ((100 + percent))) / 100
    eema_down = (eema.round(3) * ((100 - percent))) / 100

    [eema_up.truncate(3), eema.truncate(3), eema_down.truncate(3)]
  end
end

class Array
  include EnvelopesEma
end
