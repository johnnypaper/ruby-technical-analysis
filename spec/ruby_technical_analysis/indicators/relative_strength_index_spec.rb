require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe RelativeStrengthIndex do
    let(:series) { [37.8750, 39.5000, 38.7500, 39.8125, 40.0000, 39.8750] }
    let(:period) { 5 }

    let(:rsi) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the RelativeStrengthIndex object" do
        expect(rsi).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 14" do
        expect(described_class.new(series: series).period).to eq(14)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:rsi) { described_class.call(series: series, period: period) }

        it "returns the RelativeStrengthIndex value" do
          expect(rsi).to eq(76.6667)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the RelativeStrengthIndex value" do
          expect(rsi.call).to eq(76.6667)
        end
      end
    end
  end
end
