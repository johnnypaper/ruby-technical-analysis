require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe BollingerBands do
    let(:series) { [31.8750, 32.1250, 32.3125, 32.1250, 31.8750] }
    let(:period) { 5 }

    let(:bollinger_bands) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the BollingerBands object" do
        expect(bollinger_bands).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 20" do
        expect(described_class.new(series: series).period).to eq(20)
      end

      it "initializes with default standard deviations of 2" do
        expect(described_class.new(series: series).standard_deviations).to eq(2)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:bollinger_bands) { described_class.call(series: series, period: period) }

        it "returns an array containing the current upper, middle, and lower bands of the series" do
          expect(bollinger_bands).to eq([32.397, 32.062, 31.727])
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns an array containing the current upper, middle, and lower bands of the series" do
          expect(bollinger_bands.call).to eq([32.397, 32.062, 31.727])
        end
      end
    end
  end
end
