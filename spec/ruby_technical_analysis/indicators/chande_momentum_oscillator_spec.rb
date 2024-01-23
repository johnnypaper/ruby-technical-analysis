require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe ChandeMomentumOscillator do
    let(:series) { [51.0625, 50.1250, 52.3125, 52.1875, 53.1875, 53.0625] }
    let(:period) { 5 }

    let(:oscillator) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the ChandeMomentumOscillator object" do
        expect(oscillator).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 20" do
        expect(described_class.new(series: series).period).to eq(20)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:oscillator) { described_class.call(series: series, period: period) }

        it "returns the ChandeMomentumOscillator value" do
          expect(oscillator.truncate(4)).to eq(45.7143)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the ChandeMomentumOscillator value" do
          expect(oscillator.call.truncate(4)).to eq(45.7143)
        end
      end
    end
  end
end
