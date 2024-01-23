require "spec_helper"

module RubyTechnicalAnalysis
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
    end

    describe "#variance" do
      it "returns the variance value" do
        expect(stats.variance).to eq(1.25)
      end
    end

    describe "#standard_deviation" do
      it "returns the standard_deviation value" do
        expect(stats.standard_deviation.truncate(5)).to eq(1.11803)
      end
    end
  end
end
