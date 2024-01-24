require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe ChaikinMoneyFlow do
    let(:series) {
      [[8.625, 8.3125, 8.625, 4494], [8.625, 8.4375, 8.5, 2090], [8.625, 8.4375, 8.625, 1306],
        [8.75, 8.625, 8.75, 4242], [8.75, 8.4375, 8.5, 2874]]
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

      describe "#valid?" do
        it "returns true when the period is less than or equal to the series length" do
          expect(cmf.valid?).to be(true)
        end

        it "returns false when the period is greater than the series length" do
          expect(described_class.new(series: series, period: 6).valid?).to be(false)
        end
      end
    end

    describe "secondary series" do
      series = [[8.625, 8.3125, 8.625, 4494], [8.625, 8.4375, 8.5, 2090], [8.625, 8.4375, 8.625, 1306],
        [8.75, 8.625, 8.75, 4242], [8.75, 8.4375, 8.5, 2874], [8.5625, 8.5, 8.5, 598]]
      period = 5

      expected_value = 0.22763

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call.truncate(5)).to eq(expected_value)
      end
    end
  end
end
