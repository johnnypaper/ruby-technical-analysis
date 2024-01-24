module Rta
  # Price Channel
  #
  # Find more information at: https://www.investopedia.com/terms/p/price-channel.asp
  class PriceChannel < Indicator
    attr_reader :period

    # @param series [Array] An array of arrays containing high, low prices, e.g. [[high, low], [high, low]]
    # @param period [Integer] The number of periods to use in the calculation
    def initialize(series: [], period: 20)
      @period = period

      super(series: series)
    end

    # @return [Array] An array containing the current upper and lower price channel values
    def call
      calculate_price_channel
    end

    private

    def _highs
      @_highs ||= series.last(period + 1).map { |value| value.at(0) }
    end

    def _lows
      @_lows ||= series.last(period + 1).map { |value| value.at(1) }
    end

    def upper_price_channel
      _highs[0..period - 1].max
    end

    def lower_price_channel
      _lows[0..period - 1].min
    end

    def calculate_price_channel
      [upper_price_channel, lower_price_channel]
    end
  end
end
