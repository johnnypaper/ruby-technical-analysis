require "spec_helper"

module Rta
  RSpec.describe StatisticalMethods do
    let(:series) { [0, 1, 2, 3] }

    let(:stats) { described_class.new(series: series) }

    describe "#initialize" do
      it "initializes the StatisticalMethods object" do
        expect(stats).to be_an_instance_of(described_class)
      end
    end

    describe "#mean" do
      it "returns the mean value" do
        expect(stats.mean).to eq(1.5)
      end

      context "secondary series" do
        series = [-1, 1, 2, -2]

        it "returns the expected value" do
          expect(described_class.new(series: series).mean).to eq(0)
        end
      end

      context "when the series is all zeros" do
        series = [0, 0, 0, 0]

        it "returns 0" do
          expect(described_class.new(series: series).mean).to eq(0)
        end
      end
    end

    describe "#variance" do
      it "returns the variance value" do
        expect(stats.variance).to eq(1.25)
      end

      context "secondary series" do
        series = [-1, 1, 2, -2]

        it "returns the expected value" do
          expect(described_class.new(series: series).variance).to eq(2.5)
        end
      end

      context "when the series is all zeros" do
        series = [0, 0, 0, 0]

        it "returns 0" do
          expect(described_class.new(series: series).variance).to eq(0)
        end
      end
    end

    describe "#standard_deviation" do
      it "returns the standard_deviation value" do
        expect(stats.standard_deviation.truncate(5)).to eq(1.11803)
      end

      context "secondary series" do
        series = [-1, 1, 2, -2]

        it "returns the expected value" do
          expect(described_class.new(series: series).standard_deviation.truncate(5)).to eq(1.58113)
        end
      end

      context "when the series is all zeros" do
        series = [0, 0, 0, 0]

        it "returns 0" do
          expect(described_class.new(series: series).standard_deviation).to eq(0)
        end
      end
    end

    describe "#valid?" do
      it "returns true when the series is valid" do
        expect(stats.valid?).to be(true)
      end

      it "returns false when the series is not valid" do
        expect(described_class.new(series: []).valid?).to be(false)
      end
    end
  end
end
