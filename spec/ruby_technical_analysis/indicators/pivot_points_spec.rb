require "spec_helper"

module RubyTechnicalAnalysis
  RSpec.describe PivotPoints do
    let(:series) { [176.65, 152.00, 165.12] }

    let(:pivot_points) { described_class.new(series: series) }

    describe "#initialize" do
      it "initializes the PivotPoints object" do
        expect(pivot_points).to be_an_instance_of(described_class)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:pivot_points) { described_class.call(series: series) }

        it "returns an array containing the current support levels, pivot, and resistance levels" do
          expect(pivot_points).to eq([127.88, 139.94, 152.53, 164.59, 177.18, 189.24, 201.83])
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns an array containing the current support levels, pivot, and resistance levels" do
          expect(pivot_points.call).to eq([127.88, 139.94, 152.53, 164.59, 177.18, 189.24, 201.83])
        end
      end
    end
  end
end
