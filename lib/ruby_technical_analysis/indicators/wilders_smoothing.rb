module RubyTechnicalAnalysis
  # Wilders Smoothing
  class WildersSmoothing < Indicator
    attr_reader :period

    # @param price_series [Array] An array of prices
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(price_series, period = 5)
      @period = period

      super(price_series)
    end

    # @return [Float] The current Wilders Smoothing value
    def call
      calculate_wilders_smoothing
    end

    private

    def _sma_first_period
      @_sma_first_period ||=
        Array(RubyTechnicalAnalysis::MovingAverages.new(price_series.first(period), period).sma)
    end

    def smoothing_length
      (price_series.size - period - 1)
    end

    def calculate_wilders_smoothing
      ws = _sma_first_period

      (0..smoothing_length).each do |index|
        current_smoothing = ws.at(index)

        ws << ((price_series.at(index + period) - current_smoothing) * (1.0 / period)) + current_smoothing
      end

      ws.last
    end
  end
end
