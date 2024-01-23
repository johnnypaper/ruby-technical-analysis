require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe MovingAverages do
    let(:series) { [25.000, 24.875, 24.781, 24.594, 24.5] }
    let(:period) { 5 }

    let(:moving_averages) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the MovingAverages object" do
        expect(moving_averages).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 20" do
        expect(described_class.new(series: series).period).to eq(20)
      end
    end

    describe "#sma" do
      it "returns the simple moving average value" do
        expect(moving_averages.sma.round(3)).to eq(24.75)
      end
    end

    describe "#ema" do
      it "returns the exponential moving average value" do
        expect(moving_averages.ema.round(3)).to eq(24.698)
      end
    end

    describe "#wma" do
      it "returns the weighted moving average value" do
        expect(moving_averages.wma.round(3)).to eq(24.665)
      end
    end
  end
end
