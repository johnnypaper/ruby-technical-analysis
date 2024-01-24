require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe VolumeRateOfChange do
    let(:series) { [9_996, 12_940, 37_524, 21_032, 14_880, 21_304] }
    let(:period) { 5 }

    let(:vroc) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the VolumeRateOfChange object" do
        expect(vroc).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 25" do
        expect(described_class.new(series: series).period).to eq(25)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:vroc) { described_class.call(series: series, period: period) }

        it "returns the VolumeRateOfChange value" do
          expect(vroc).to eq(113.1253)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the VolumeRateOfChange value" do
          expect(vroc.call).to eq(113.1253)
        end
      end
    end

    describe "secondary series" do
      series = [9_996, 12_940, 37_524, 21_032, 14_880, 21_304, 15_776]
      period = 5

      expected_value = 21.9165

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call).to eq(expected_value)
      end
    end
  end
end
