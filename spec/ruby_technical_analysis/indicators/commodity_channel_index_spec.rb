require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe CommodityChannelIndex do
    let(:series) {
      [[15.125, 14.936, 14.936], [15.052, 14.6267, 14.752], [14.8173, 14.5557, 14.5857],
        [14.69, 14.46, 14.6], [14.7967, 14.5483, 14.6983], [14.7940, 13.9347, 13.946],
        [14.093, 13.8223, 13.9827], [14.7, 14.02, 14.45], [14.5255, 14.2652, 14.3452]]
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

      describe "#valid?" do
        it "returns true when the series is valid" do
          expect(cci.valid?).to be_truthy
        end

        it "returns false when the series is not valid" do
          expect(described_class.new(series: [], period: period).valid?).to be(false)
        end
      end
    end

    describe "secondary series" do
      series = [[15.125, 14.936, 14.936], [15.052, 14.6267, 14.752], [14.8173, 14.5557, 14.5857],
        [14.69, 14.46, 14.6], [14.7967, 14.5483, 14.6983], [14.794, 13.9347, 13.946],
        [14.093, 13.8223, 13.9827], [14.7, 14.02, 14.45], [14.5255, 14.2652, 14.3452],
        [14.6579, 14.3773, 14.4197]]
      period = 5

      expected_value = 84.4605

      it "returns the expected value" do
        expect(described_class.new(series: series, period: period).call.truncate(4)).to eq(expected_value)
      end
    end
  end
end
