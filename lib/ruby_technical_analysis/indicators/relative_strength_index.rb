module RubyTechnicalAnalysis
  # Relative Strength Index
  #
  # Find more information at: https://www.fidelity.com/viewpoints/active-investor/how-to-use-RSI
  class RelativeStrengthIndex < Indicator
    attr_reader :period

    # @param series [Array] An array of prices, typically closing prices
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(series: [], period: 14)
      @period = period
      @rsi = []
      @smooth_up = []
      @smooth_down = []
      @wilders_is_set = false

      super(series: series)
    end

    # @return [Float] The current RSI value
    def call
      calculate_rsi
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      period < series.length
    end

    private

    def _smooth_coef_one
      @_smooth_coef_one ||= (1.0 / period).round(4)
    end

    def _smooth_coef_two
      @_smooth_coef_two ||= (1 - _smooth_coef_one)
    end

    def calculate_channels(cla)
      period.times.map do |index|
        diff = (cla.at(index) - cla.at(index + 1)).round(4)

        [diff.negative? ? diff.abs : 0, diff.positive? ? diff : 0]
      end.transpose
    end

    def calculate_initial_smoothing(up_ch, down_ch)
      @smooth_up << RubyTechnicalAnalysis::WildersSmoothing.call(series: up_ch, period: period)
      @smooth_down << RubyTechnicalAnalysis::WildersSmoothing.call(series: down_ch, period: period)

      @wilders_is_set = true
    end

    def calculate_subsequent_smoothing(up_ch, down_ch)
      @smooth_up << (_smooth_coef_one * up_ch.last + _smooth_coef_two * @smooth_up.last).round(4)
      @smooth_down << (_smooth_coef_one * down_ch.last + _smooth_coef_two * @smooth_down.last).round(4)
    end

    def calculate_smoothing(up_ch, down_ch)
      @wilders_is_set ? calculate_subsequent_smoothing(up_ch, down_ch) : calculate_initial_smoothing(up_ch, down_ch)
    end

    def calculate_rsi
      (0..(series.size - period - 1)).flat_map do |index|
        cla = series[index..index + period]
        up_ch, down_ch = calculate_channels(cla)

        calculate_smoothing(up_ch, down_ch)
        @rsi << (100.00 - (100.00 / ((@smooth_up.last.to_f / @smooth_down.last) + 1))).round(4)
      end.last
    end
  end
end
