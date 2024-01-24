require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe MassIndex do
    let(:series) {
      [[38.125, 37.75], [38, 37.75], [37.9375, 37.8125], [37.875, 37.625], [38.125, 37.5],
        [38.125, 37.5], [37.75, 37.5], [37.625, 37.4375], [37.6875, 37.375], [37.5, 37.375],
        [37.5625, 37.375], [37.625, 36.8125], [36.6875, 36.3125], [36.875, 36.25], [36.9375, 36.5],
        [36.5, 36.25], [36.9375, 36.3125], [37, 36.625], [36.875, 36.5625]]
    }
    let(:period) { 9 }

    let(:mass_index) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the MassIndex object" do
        expect(mass_index).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 9" do
        expect(described_class.new(series: series).period).to eq(9)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:mass_index) { described_class.call(series: series, period: period) }

        it "returns the MassIndex value" do
          expect(mass_index).to eq(3.2236)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the MassIndex value" do
          expect(mass_index.call).to eq(3.2236)
        end
      end
    end

    describe "secondary series" do
      series = [[38.125, 37.75], [38, 37.75], [37.9375, 37.8125], [37.875, 37.625], [38.125, 37.5],
        [38.125, 37.5], [37.75, 37.75], [37.625, 37.4375], [37.6875, 37.375], [37.75, 37.375],
        [37.5625, 37.375], [37.625, 36.8125], [36.6875, 36.3125], [36.875, 36.25], [36.9375, 36.5],
        [36.5, 36.25], [36.9375, 36.3125], [37, 36.625], [36.875, 36.5625], [36.8125, 36.375]]
      period = 9

      expected_value = 3.1387

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call).to eq(expected_value)
      end
    end
  end
end
