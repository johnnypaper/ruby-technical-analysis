require "spec_helper"

module Rta
  RSpec.describe Macd do
    let(:series) {
      [166.23, 164.51, 162.41, 161.62, 159.78, 159.69, 159.22, 170.33,
        174.78, 174.61, 175.84, 172.9, 172.39, 171.66, 174.83, 176.28,
        172.12, 168.64, 168.88, 172.79, 172.55, 168.88, 167.3, 164.32,
        160.07, 162.74, 164.85, 165.12, 163.2, 166.56, 166.23, 163.17,
        159.3, 157.44, 162.95]
    }

    let(:macd) { described_class.new(series: series) }

    describe "#initialize" do
      it "initializes the Macd object" do
        expect(macd).to be_an_instance_of(described_class)
      end

      it "initializes with default fast_period of 12" do
        expect(described_class.new(series: series).fast_period).to eq(12)
      end

      it "initializes with default slow_period of 26" do
        expect(described_class.new(series: series).slow_period).to eq(26)
      end

      it "initializes with default signal_period of 9" do
        expect(described_class.new(series: series).signal_period).to eq(9)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:macd) { described_class.call(series: series) }

        it "returns an array containing the current upper, middle, and lower bands of the series" do
          expect(macd).to eq([-1.934, -1.664, -0.27])
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns an array containing the current upper, middle, and lower bands of the series" do
          expect(macd.call).to eq([-1.934, -1.664, -0.27])
        end
      end

      describe "#valid?" do
        it "returns true when the series is valid" do
          expect(macd.valid?).to be(true)
        end

        it "returns false when the series is not valid" do
          expect(described_class.new(series: [], fast_period: 12, slow_period: 26, signal_period: 9).valid?).to be(false)
        end
      end
    end
  end
end
