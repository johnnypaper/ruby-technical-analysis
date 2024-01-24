require "spec_helper"

module Rta
  RSpec.describe WildersSmoothing do
    let(:series) { [62.125, 61.125, 62.3438, 65.3125, 63.9688, 63.4375] }
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

      describe "#valid?" do
        context "when the period is greater than or equal to the series length" do
          let(:period) { 6 }

          it "returns false" do
            expect(wilders_smoothing.valid?).to eq(false)
          end
        end

        context "when the period is less than the series length" do
          let(:period) { 5 }

          it "returns true" do
            expect(wilders_smoothing.valid?).to eq(true)
          end
        end
      end
    end

    describe "secondary series" do
      series = [62.125, 61.125, 62.3438, 65.3125, 63.9688, 63.4375, 63]
      period = 5

      expected_value = 63.054

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call.truncate(4)).to eq(expected_value)
      end
    end
  end
end
