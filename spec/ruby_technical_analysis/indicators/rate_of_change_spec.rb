require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe RateOfChange do
    let(:series) { [5.5625, 5.3750, 5.3750, 5.0625] }
    let(:period) { 3 }

    let(:roc) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the RateOfChange object" do
        expect(roc).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 30" do
        expect(described_class.new(series: series).period).to eq(30)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:roc) { described_class.call(series: series, period: period) }

        it "returns the RateOfChange value" do
          expect(roc).to eq(-8.99)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the RateOfChange value" do
          expect(roc.call).to eq(-8.99)
        end
      end
    end
  end
end
