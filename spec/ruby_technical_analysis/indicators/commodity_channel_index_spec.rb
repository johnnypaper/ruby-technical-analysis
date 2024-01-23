require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe CommodityChannelIndex do
    let(:series) {
      [[15.1250, 14.9360, 14.9360], [15.0520, 14.6267, 14.7520], [14.8173, 14.5557, 14.5857],
        [14.6900, 14.4600, 14.6000], [14.7967, 14.5483, 14.6983], [14.7940, 13.9347, 13.9460],
        [14.0930, 13.8223, 13.9827], [14.7000, 14.0200, 14.4500], [14.5255, 14.2652, 14.3452]]
    }
    let(:period) { 5 }

    let(:cci) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the CommodityChannelIndex object" do
        expect(cci).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 20" do
        expect(described_class.new(series: series).period).to eq(20)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:cci) { described_class.call(series: series, period: period) }

        it "returns the CommodityChannelIndex value" do
          expect(cci.truncate(4)).to eq(18.089)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the CommodityChannelIndex value" do
          expect(cci.call.truncate(4)).to eq(18.089)
        end
      end
    end
  end
end
