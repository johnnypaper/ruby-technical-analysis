require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe RelativeStrengthIndex do
    let(:series) { [37.875, 39.5, 38.75, 39.8125, 40, 39.875] }
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

      describe "#valid?" do
        it "returns true when the series is valid" do
          expect(rsi.valid?).to be(true)
        end

        it "returns false when the series is not valid" do
          expect(described_class.new(series: [*1..5], period: period).valid?).to be(false)
        end
      end
    end

    describe "secondary series" do
      series = [37.875, 39.5, 38.75, 39.8125, 40, 39.875, 40.1875]
      period = 5

      expected_value = 78.8679

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call).to eq(expected_value)
      end
    end
  end
end
