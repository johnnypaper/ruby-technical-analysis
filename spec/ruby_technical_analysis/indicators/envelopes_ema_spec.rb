require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe EnvelopesEma do
    let(:series) { [25, 24.875, 24.781, 24.594, 24.5] }
    let(:period) { 5 }
    let(:percent) { 20 }

    let(:envelopes_ema) { described_class.new(series: series, period: period, percent: 20) }

    describe "#initialize" do
      it "initializes the EnvelopesEma object" do
        expect(envelopes_ema).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 20" do
        expect(described_class.new(series: series).period).to eq(20)
      end

      it "initializes with default percent of 5" do
        expect(described_class.new(series: series).percent).to eq(5)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:envelopes_ema) { described_class.call(series: series, period: period, percent: 20) }

        it "returns an array containing the current upper, middle, and lower bands of the series" do
          expect(envelopes_ema).to eq([29.637, 24.698, 19.758])
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns an array containing the current upper, middle, and lower bands of the series" do
          expect(envelopes_ema.call).to eq([29.637, 24.698, 19.758])
        end
      end
    end

    describe "secondary series" do
      series = [25, 24.875, 24.781, 24.594, 24.5, 24.625]
      period = 5
      percent = 20

      expected_values = [29.588, 24.657, 19.725]

      it "returns the expected values" do
        expect(described_class.new(series: series, period: period, percent: percent).call).to eq(expected_values)
      end
    end
  end
end
