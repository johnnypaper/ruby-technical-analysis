# frozen_string_literal: true

require_relative "../../ruby-technical-analysis/moving_averages"

module RTA
  # Envelopes EMA indicator
  # Returns an array of current high, middle and low eema values
  class EnvelopesEma
    attr_accessor :price_series, :period, :percent

    def initialize(price_series, period, percent)
      @price_series = price_series
      @period = period
      @percent = percent
    end

    def call
      eema = RTA::MovingAverages.new(price_series.last(period)).ema(period)

      eema_up = (eema * (100 + percent)) / 100
      eema_down = (eema * (100 - percent)) / 100

      [eema_up, eema, eema_down].map { |val| val.truncate(3) }
    end
  end
end
