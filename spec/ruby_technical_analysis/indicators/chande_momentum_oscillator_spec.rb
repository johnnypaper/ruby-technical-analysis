require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe ChandeMomentumOscillator do
    let(:series) { [51.0625, 50.125, 52.3125, 52.1875, 53.1875, 53.0625] }
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

      describe "#valid?" do
        it "returns true when the period is less than or equal to the series length" do
          expect(oscillator.valid?).to be(true)
        end

        it "returns false when the period is greater than the series length" do
          expect(described_class.new(series: series, period: 6).valid?).to be(false)
        end
      end
    end

    describe "secondary series" do
      series = [51.0625, 50.125, 52.3125, 52.1875, 53.1875, 53.0625, 54.0625]
      period = 5

      expected_value = 88.7324

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call.truncate(4)).to eq(expected_value)
      end
    end
  end
end
