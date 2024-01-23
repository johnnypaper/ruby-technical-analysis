require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe IntradayMomentumIndex do
    let(:series) {
      [[18.4833, 18.5000], [18.5417, 18.4167], [18.4167, 18.1667], [18.1667, 18.1250], [18.1667, 17.9583],
        [18.0417, 18.0000], [18.0000, 17.9583], [17.9167, 17.8333], [17.7917, 17.9583]]
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
    end
  end
end
