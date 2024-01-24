require "spec_helper"

module Rta
  RSpec.describe QStick do
    let(:series) { [[62.5625, 64.5625], [64.625, 64.125], [63.5625, 64.3125], [63.9375, 64.875]] }
    let(:period) { 4 }

    let(:q_stick) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the QStick object" do
        expect(q_stick).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 20" do
        expect(described_class.new(series: series).period).to eq(20)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:q_stick) { described_class.call(series: series, period: period) }

        it "returns the QStick value" do
          expect(q_stick).to eq(0.7969)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the QStick value" do
          expect(q_stick.call).to eq(0.7969)
        end
      end

      describe "#valid?" do
        it "returns true when the series is valid" do
          expect(q_stick.valid?).to be(true)
        end

        it "returns false when the series is not valid" do
          expect(described_class.new(series: [], period: period).valid?).to be(false)
        end
      end
    end

    describe "secondary series" do
      series = [[62.5625, 64.5625], [64.625, 64.125], [63.5625, 64.3125], [63.9375, 64.875], [64.5, 65.1875]]
      period = 4

      expected_value = 0.4688

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call).to eq(expected_value)
      end
    end
  end
end
