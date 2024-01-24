require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe WilliamsPercentR do
    let(:series) {
      [[631.34, 624.81, 626.01], [627.11, 623.59, 626.44], [628.49, 621.33, 622.2],
        [630.89, 622.2, 630.8], [632.85, 630.21, 632.85], [633.26, 629.64, 633.06]]
    }
    let(:period) { 5 }

    let(:williams_percent_r) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the WilliamsPercentR object" do
        expect(williams_percent_r).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 14" do
        expect(described_class.new(series: series).period).to eq(14)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:williams_percent_r) { described_class.call(series: series, period: period) }

        it "returns the WilliamsPercentR value" do
          expect(williams_percent_r).to eq(-1.68)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the WilliamsPercentR value" do
          expect(williams_percent_r.call).to eq(-1.68)
        end
      end
    end

    describe "secondary series" do
      series = [[631.34, 624.81, 626.01], [627.11, 623.59, 626.44], [628.49, 621.33, 622.2],
        [630.89, 622.2, 630.8], [632.85, 630.21, 632.85], [633.26, 629.64, 633.06]]
      period = 5

      expected_value = -1.68

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call).to eq(expected_value)
      end
    end
  end
end
