# frozen_string_literal: true

require_relative "indicator"
require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Envelopes EMA indicator
  # Returns an array of current high, middle and low eema values
  class EnvelopesEma < Indicator
    attr_reader :period, :percent

    def initialize(price_series, period, percent)
      @period = period
      @percent = percent

      super(price_series)
    end

    def call
      caluculate_envelopes_ema
    end

    private

    def _eema
      @_eema ||= moving_averages(period).ema(period)
    end

    def eema_up
      (_eema * (100 + percent)) / 100
    end

    def eema_down
      (_eema * (100 - percent)) / 100
    end

    def caluculate_envelopes_ema
      [eema_up, _eema, eema_down].map { |val| val.truncate(3) }
    end
  end
end
