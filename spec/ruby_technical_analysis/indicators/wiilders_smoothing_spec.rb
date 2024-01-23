require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe WildersSmoothing do
    let(:series) { [62.1250, 61.1250, 62.3438, 65.3125, 63.9688, 63.4375] }
    let(:period) { 5 }

    let(:wilders_smoothing) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the WildersSmoothing object" do
        expect(wilders_smoothing).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 5" do
        expect(described_class.new(series: series).period).to eq(5)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:wilders_smoothing) { described_class.call(series: series, period: period) }

        it "returns the WildersSmoothing value" do
          expect(wilders_smoothing.truncate(4)).to eq(63.0675)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the WildersSmoothing value" do
          expect(wilders_smoothing.call.truncate(4)).to eq(63.0675)
        end
      end
    end
  end
end
