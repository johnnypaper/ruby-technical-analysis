module RubyTechnicalAnalysis
  # Wilders Smoothing
  class WildersSmoothing < Indicator
    attr_reader :period

    # @param series [Array] An array of prices
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(series: [], period: 5)
      @period = period

      super(series: series)
    end

    # @return [Float] The current Wilders Smoothing value
    def call
      calculate_wilders_smoothing
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      period < series.length
    end

    private

    def _sma_first_period
      @_sma_first_period ||=
        Array(RubyTechnicalAnalysis::MovingAverages.new(series: series.first(period), period: period).sma)
    end

    def smoothing_length
      (series.size - period - 1)
    end

    def calculate_wilders_smoothing
      ws = _sma_first_period

      (0..smoothing_length).each do |index|
        current_smoothing = ws.at(index)

        ws << ((series.at(index + period) - current_smoothing) * (1.0 / period)) + current_smoothing
      end

      ws.last
    end
  end
end
