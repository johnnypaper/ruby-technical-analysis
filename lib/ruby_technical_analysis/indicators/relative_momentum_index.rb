module RubyTechnicalAnalysis
  # Relative Momentum Index
  class RelativeMomentumIndex < Indicator
    attr_reader :period_mom, :period_rmi

    # @param series [Array] An array of prices, typically closing prices
    # @param period_mom [Integer] The number of periods to use in the momentum calculation
    # @param period_rmi [Integer] The number of periods to use in the RMI calculation
    def initialize(series: [], period_mom: 14, period_rmi: 20)
      @period_mom = period_mom
      @period_rmi = period_rmi
      @rmi = []
      @rmi_intermediate = []
      @smooth_up = []
      @smooth_down = []
      @wilders_is_set = false

      super(series: series)
    end

    # @return [Float] The current RMI value
    def call
      calculate_rmi
    end

    # @return [Boolean] Whether or not the object is valid
    def valid?
      period_mom + period_rmi <= series.length
    end

    private

    def _pmpr
      @_pmpr ||= (period_mom + period_rmi)
    end

    def _smooth_coef_one
      @_smooth_coef_one ||= (1.0 / period_rmi).round(4)
    end

    def _smooth_coef_two
      @_smooth_coef_two ||= (1 - _smooth_coef_one)
    end

    def calculate_channels(cla)
      period_rmi.times.map do |index|
        diff = (cla.at(index) - cla.at(period_mom + index)).round(4)
        [diff.negative? ? diff.abs : 0, diff.positive? ? diff : 0]
      end.transpose
    end

    def calculate_initial_smoothing(up_ch, down_ch)
      @smooth_up << RubyTechnicalAnalysis::WildersSmoothing.call(series: up_ch, period: period_rmi)
      @smooth_down << RubyTechnicalAnalysis::WildersSmoothing.call(series: down_ch, period: period_rmi)
      @wilders_is_set = true
    end

    def calculate_subsequent_smoothing(up_ch, down_ch)
      @smooth_up << (_smooth_coef_one * up_ch.last + _smooth_coef_two * @smooth_up.last).round(4)
      @smooth_down << (_smooth_coef_one * down_ch.last + _smooth_coef_two * @smooth_down.last).round(4)
    end

    def calculate_smoothing(up_ch, down_ch)
      @wilders_is_set ? calculate_subsequent_smoothing(up_ch, down_ch) : calculate_initial_smoothing(up_ch, down_ch)
    end

    def calculate_rmi
      (0..(series.size - _pmpr)).flat_map do |index|
        cla = series[index..(index + _pmpr - 1)]
        up_ch, down_ch = calculate_channels(cla)

        calculate_smoothing(up_ch, down_ch)

        @rmi_intermediate << (@smooth_up.last.to_f / @smooth_down.last)
        @rmi << ((@rmi_intermediate.last.to_f / (1 + @rmi_intermediate.last)) * 100).round(4)
      end.last
    end
  end
end
