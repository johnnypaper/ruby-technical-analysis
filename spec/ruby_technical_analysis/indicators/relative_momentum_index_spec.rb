require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe RelativeMomentumIndex do
    let(:series) {
      [6.875, 6.9375, 6.8125, 6.6095, 6.7345, 6.672, 6.625, 6.6875, 6.547, 6.6563, 6.672, 6.6563]
    }
    let(:period_mom) { 4 }
    let(:period_rmi) { 8 }

    let(:rmi) { described_class.new(series: series, period_mom: period_mom, period_rmi: period_rmi) }

    describe "#initialize" do
      it "initializes the RelativeMomentumIndex object" do
        expect(rmi).to be_an_instance_of(described_class)
      end

      it "initializes with default period_mom of 14" do
        expect(described_class.new(series: series).period_mom).to eq(14)
      end

      it "initializes with default period_rmi of 20" do
        expect(described_class.new(series: series).period_rmi).to eq(20)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:rmi) { described_class.call(series: series, period_mom: period_mom, period_rmi: period_rmi) }

        it "returns the RelativeMomentumIndex value" do
          expect(rmi).to eq(13.1179)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the RelativeMomentumIndex value" do
          expect(rmi.call).to eq(13.1179)
        end
      end
    end

    describe "secondary series" do
      series = [6.875, 6.9375, 6.8125, 6.6095, 6.7345, 6.672, 6.625, 6.6875, 6.547, 6.6563, 6.672, 6.6563, 6.5938]
      period_mom = 4
      period_rmi = 8

      expected_value = 17.7112

      it "returns the expected value" do
        expect(described_class.new(series: series, period_mom: period_mom, period_rmi: period_rmi).call).to eq(expected_value)
      end
    end
  end
end
