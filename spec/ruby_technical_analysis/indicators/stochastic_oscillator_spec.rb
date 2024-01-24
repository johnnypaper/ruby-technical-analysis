require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe StochasticOscillator do
    let(:series) {
      [[34.375, 33.5312, 34.3125], [34.75, 33.9062, 34.125], [34.2188, 33.6875, 33.75],
        [33.8281, 33.25, 33.6406], [33.4375, 33, 33.0156], [33.4688, 32.9375, 33.0469],
        [34.375, 33.25, 34.2969], [34.7188, 34.0469, 34.1406], [34.625, 33.9375, 34.5469]]
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

      describe "#valid?" do
        it "returns true when the series is valid" do
          expect(oscillator.valid?).to be(true)
        end

        it "returns false when the series is not valid" do
          expect(
            described_class.new(
              series: [*1..(k_periods + d_periods - 1)],
              k_periods: k_periods,
              k_slow_periods: k_slow_periods,
              d_periods: d_periods
            ).valid?
          ).to be(false)
        end
      end
    end

    describe "secondary series" do
      series = [[34.375, 33.5312, 34.3125], [34.75, 33.9062, 34.125], [34.2188, 33.6875, 33.75],
        [33.8281, 33.25, 33.6406], [33.4375, 33, 33.0156], [33.4688, 32.9375, 33.0469],
        [34.375, 33.25, 34.2969], [34.7188, 34.0469, 34.1406], [34.625, 33.9375, 34.5469],
        [34.9219, 34.0625, 34.3281]]
      k_periods = 5
      k_slow_periods = 3
      d_periods = 3

      expected_value = 70.7715

      it "returns the expected value" do
        expect(
          described_class.new(
            series: series,
            k_periods: k_periods,
            k_slow_periods: k_slow_periods,
            d_periods: d_periods
          ).call
        ).to eq(expected_value)
      end
    end
  end
end
