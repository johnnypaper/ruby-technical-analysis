require "spec_helper"

module Rta
  RSpec.describe Indicator do
    describe "#initialize" do
      series = [10, 20, 30, 40, 50]
      indicator = described_class.new(series: series)

      it "initializes with a series of series" do
        expect(indicator.series).to eq(series)
      end
    end

    describe "#call" do
      it "is a class method" do
        expect(described_class).to respond_to(:call)
      end
    end

    # Private methods only tested for base class

    describe "#extract_series" do
      series = [10, 20, 30, 40, 50]
      indicator = described_class.new(series: series)

      it "extracts the series from the series" do
        expect(indicator.send(:extract_series)).to eq(series)
      end
    end

    describe "#extract_highs_lows_closes_volumes" do
      highs = [1, 2, 3, 4, 5]
      lows = [6, 7, 8, 9, 10]
      closes = [11, 12, 13, 14, 15]
      volumes = [100, 200, 300, 400, 500]

      series = highs.zip(lows, closes, volumes)
      indicator = described_class.new(series: series)

      it "extracts the highs, lows, closes, and volumes from the series" do
        expect(indicator.send(:extract_highs_lows_closes_volumes)).to eq([highs, lows, closes, volumes])
      end
    end

    describe "#extract_highs_lows_closes" do
      highs = [1, 2, 3, 4, 5]
      lows = [6, 7, 8, 9, 10]
      closes = [11, 12, 13, 14, 15]

      series = highs.zip(lows, closes)
      indicator = described_class.new(series: series)

      it "extracts the highs, lows, and closes from the series" do
        expect(indicator.send(:extract_highs_lows_closes)).to eq([highs, lows, closes])
      end
    end

    describe "#moving_averages" do
      series = [10, 20, 30, 40, 50]
      indicator = described_class.new(series: series)

      it "calculates moving averages" do
        expect(indicator.send(:moving_averages, period: 3)).to be_a(Rta::MovingAverages)
      end
    end

    describe "#statistical_methods" do
      series = [10, 20, 30, 40, 50]
      indicator = described_class.new(series: series)

      it "performs statistical calculations" do
        expect(indicator.send(:statistical_methods)).to be_a(Rta::StatisticalMethods)
      end
    end
  end
end
