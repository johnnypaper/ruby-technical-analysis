require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe MassIndex do
    let(:series) {
      [[38.1250, 37.7500], [38.0000, 37.7500], [37.9375, 37.8125], [37.8750, 37.6250], [38.1250, 37.5000],
        [38.1250, 37.5000], [37.7500, 37.5000], [37.6250, 37.4375], [37.6875, 37.3750], [37.5000, 37.3750],
        [37.5625, 37.3750], [37.6250, 36.8125], [36.6875, 36.3125], [36.8750, 36.2500], [36.9375, 36.5000],
        [36.5000, 36.2500], [36.9375, 36.3125], [37.0000, 36.6250], [36.8750, 36.5625]]
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
  end
end
