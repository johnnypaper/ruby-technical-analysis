require "spec_helper"

module Rta
  RSpec.describe PriceChannel do
    let(:series) {
      [[2.8097, 2.8437], [2.9063, 2.8543], [2.875, 2.8333], [2.8543, 2.8127], [2.974, 2.8647],
        [3.073, 2.9793]]
    }

    let(:period) { 5 }

    let(:price_channel) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the PriceChannel object" do
        expect(price_channel).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 20" do
        expect(described_class.new(series: series).period).to eq(20)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:price_channel) { described_class.call(series: series, period: period) }

        it "returns an array containing the upper and lower levels" do
          expect(price_channel).to eq([2.974, 2.8127])
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns an array containing the upper and lower levels" do
          expect(price_channel.call).to eq([2.974, 2.8127])
        end
      end
    end

    describe "secondary series" do
      series = [[2.8097, 2.8437], [2.9063, 2.8543], [2.875, 2.8333], [2.8543, 2.8127], [2.974, 2.8647],
        [3.073, 2.9793], [3.1563, 3.0937]]
      period = 5

      expected_values = [3.073, 2.8127]

      it "returns the expected values" do
        expect(described_class.new(series: series, period: period).call).to eq(expected_values)
      end
    end
  end
end
