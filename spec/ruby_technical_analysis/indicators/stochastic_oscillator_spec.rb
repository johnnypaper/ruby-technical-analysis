require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe StochasticOscillator do
    let(:series) {
      [[34.3750, 33.5312, 34.3125], [34.7500, 33.9062, 34.1250], [34.2188, 33.6875, 33.7500],
        [33.8281, 33.2500, 33.6406], [33.4375, 33.0000, 33.0156], [33.4688, 32.9375, 33.0469],
        [34.3750, 33.2500, 34.2969], [34.7188, 34.0469, 34.1406], [34.6250, 33.9375, 34.5469]]
    }
    let(:k_periods) { 5 }
    let(:k_slow_periods) { 3 }
    let(:d_periods) { 3 }

    let(:oscillator) {
      described_class.new(
        series: series,
        k_periods: k_periods,
        k_slow_periods: k_slow_periods,
        d_periods: d_periods
      )
    }

    describe "#initialize" do
      it "initializes the StochasticOscillator object" do
        expect(oscillator).to be_an_instance_of(described_class)
      end

      it "initializes with default k_periods of 14" do
        expect(described_class.new(series: series).k_periods).to eq(14)
      end

      it "initializes with default k_slow_periods of 3" do
        expect(described_class.new(series: series).k_slow_periods).to eq(3)
      end

      it "initializes with default d_periods of 3" do
        expect(described_class.new(series: series).d_periods).to eq(3)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:oscillator) {
          described_class.call(
            series: series,
            k_periods: k_periods,
            k_slow_periods: k_slow_periods,
            d_periods: d_periods
          )
        }

        it "returns the StochasticOscillator value" do
          expect(oscillator).to eq(55.41)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the StochasticOscillator value" do
          expect(oscillator.call).to eq(55.41)
        end
      end
    end
  end
end
