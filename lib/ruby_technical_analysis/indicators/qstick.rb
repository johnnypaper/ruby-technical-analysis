module RubyTechnicalAnalysis
  # Qstick
  #
  # Find more information at: https://www.investopedia.com/terms/q/qstick.asp
  class QStick < Indicator
    attr_reader :period

    # @param price_series [Array] An array of arrays containing open, close prices, e.g. [[open, close], [open, close]]
    # @param period [Integer] The number of periods to use in the calculation, default is 4
    def initialize(price_series, period = 4)
      @period = period

      super(price_series)
    end

    # @return [Float] The current Qstick value
    def call
      calculate_qstick
    end

    private

    def _opens
      @_opens ||= price_series.last(period).map { |value| value.at(0) }
    end

    def _closes
      @_closes ||= price_series.last(period).map { |value| value.at(1) }
    end

    def cmo_sum
      _closes.zip(_opens).sum { |close, open| close - open }
    end

    def calculate_qstick
      (cmo_sum.to_f / period).round(4)
    end
  end
end
