module RubyTechnicalAnalysis
  # Envelopes EMA
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/mae
  #
  # Note that this indicator is similar but not the exact same as the one in the link above. This indicator is based on the EMA, not the SMA.
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
      @_eema ||= moving_averages(period: period).ema
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
