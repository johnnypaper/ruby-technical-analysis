require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe PriceChannel do
    let(:series) {
      [[2.8097, 2.8437], [2.9063, 2.8543], [2.8750, 2.8333], [2.8543, 2.8127], [2.9740, 2.8647],
        [3.0730, 2.9793]]
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
          expect(price_channel).to eq([2.9740, 2.8127])
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns an array containing the upper and lower levels" do
          expect(price_channel.call).to eq([2.9740, 2.8127])
        end
      end
    end
  end
end
