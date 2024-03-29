module RubyTechnicalAnalysis
  # Envelopes EMA
  #
  # Find more information at: https://www.fidelity.com/learning-center/trading-investing/technical-analysis/technical-indicator-guide/mae
  #
  # Note that this indicator is similar but not the exact same as the one in the link above. This indicator is based on the EMA, not the SMA.
  class EnvelopesEma < Indicator
    attr_reader :period, :percent

    # @param series [Array] An array of prices, typically closing prices
    # @param period [Integer] The number of periods to use in the calculation
    # @param percent [Integer] The percent to use in the calculation
    def initialize(series: [], period: 20, percent: 5)
      @period = period
      @percent = percent

      super(series: series)
    end

    # @return [Array] An array containing the current upper, middle, and lower bands of the series
    def call
      caluculate_envelopes_ema
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      period <= series.length && percent <= 100
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
