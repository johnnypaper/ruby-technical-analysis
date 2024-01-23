require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe QStick do
    let(:series) { [[62.5625, 64.5625], [64.6250, 64.1250], [63.5625, 64.3125], [63.9375, 64.8750]] }
    let(:period) { 4 }

    let(:q_stick) { described_class.new(series: series, period: period) }

    describe "#initialize" do
      it "initializes the QStick object" do
        expect(q_stick).to be_an_instance_of(described_class)
      end

      it "initializes with default period of 20" do
        expect(described_class.new(series: series).period).to eq(20)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:q_stick) { described_class.call(series: series, period: period) }

        it "returns the QStick value" do
          expect(q_stick).to eq(0.7969)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the QStick value" do
          expect(q_stick.call).to eq(0.7969)
        end
      end
    end
  end
end
