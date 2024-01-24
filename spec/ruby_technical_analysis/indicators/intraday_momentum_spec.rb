require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe IntradayMomentumIndex do
    let(:series) {
      [[18.4833, 18.5], [18.5417, 18.4167], [18.4167, 18.1667], [18.1667, 18.125], [18.1667, 17.9583],
        [18.0417, 18], [18, 17.9583], [17.9167, 17.8333], [17.7917, 17.9583]]
    }
    let(:period) { 7 }

    let(:imi) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the IntradayMomentumIndex object" do
        expect(imi).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 14" do
        expect(described_class.new(series: series).period).to eq(14)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:imi) { described_class.call(series: series, period: period) }

        it "returns the IntradayMomentumIndex value" do
          expect(imi).to eq(19.988)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the IntradayMomentumIndex value" do
          expect(imi.call).to eq(19.988)
        end
      end

      describe "#valid?" do
        it "returns true when the series is valid" do
          expect(imi.valid?).to be(true)
        end

        it "returns false when the series is not valid" do
          expect(described_class.new(series: [], period: period).valid?).to be(false)
        end
      end
    end

    describe "secondary series" do
      series = [[18.4833, 18.5], [18.5417, 18.4167], [18.4167, 18.1667], [18.1667, 18.125], [18.1667, 17.9583],
        [18.0417, 18], [18, 17.9583], [17.9167, 17.8333], [17.7917, 17.9583], [18.0417, 18.5417]]
      period = 7

      expected_value = 61.5228

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call).to eq(expected_value)
      end
    end
  end
end
