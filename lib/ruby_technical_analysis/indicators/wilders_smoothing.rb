module RubyTechnicalAnalysis
  # Wilders Smoothing indicator
  # Returns a singular current value
  class WildersSmoothing < Indicator
    attr_reader :period

    def initialize(price_series, period)
      @period = period

      super(price_series)
    end

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
