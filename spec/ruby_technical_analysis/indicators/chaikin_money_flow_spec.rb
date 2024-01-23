require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe ChaikinMoneyFlow do
    let(:series) {
      [[8.6250, 8.3125, 8.6250, 4494], [8.6250, 8.4375, 8.5000, 2090], [8.6250, 8.4375, 8.6250, 1306],
        [8.7500, 8.6250, 8.7500, 4242], [8.7500, 8.4375, 8.5000, 2874]]
    }
    let(:period) { 5 }

    let(:cmf) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the ChaikinMoneyFlow object" do
        expect(cmf).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 21" do
        expect(described_class.new(series: series).period).to eq(21)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:cmf) { described_class.call(series: series, period: period) }

        it "returns the ChaikinMoneyFlow value" do
          expect(cmf.truncate(5)).to eq(0.50786)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the ChaikinMoneyFlow value" do
          expect(cmf.call.truncate(5)).to eq(0.50786)
        end
      end
    end
  end
end
