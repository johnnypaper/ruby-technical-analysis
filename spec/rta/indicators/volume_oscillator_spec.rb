require "spec_helper"

module Rta
  RSpec.describe VolumeOscillator do
    let(:series) { [17_604, 18_918, 21_030, 13_854, 10_866] }
    let(:short_ma_period) { 2 }
    let(:long_ma_period) { 5 }

    let(:oscillator) {
      described_class.new(
        series: series,
        short_ma_period: short_ma_period,
        long_ma_period: long_ma_period
      )
    }

    describe "#initialize" do
      it "initializes the VolumeOscillator object" do
        expect(oscillator).to be_an_instance_of(described_class)
      end

      it "initializes with default short_ma_period of 20" do
        expect(described_class.new(series: series).short_ma_period).to eq(20)
      end

      it "initializes with default long_ma_period of 60" do
        expect(described_class.new(series: series).long_ma_period).to eq(60)
      end
    end

    describe "class methods" do
      describe "#call" do
        let(:oscillator) {
          described_class.call(
            series: series,
            short_ma_period: short_ma_period,
            long_ma_period: long_ma_period
          )
        }

        it "returns the VolumeOscillator value" do
          expect(oscillator).to eq(-24.88)
        end
      end
    end

    describe "instance methods" do
      describe "#call" do
        it "returns the VolumeOscillator value" do
          expect(oscillator.call).to eq(-24.88)
        end
      end

      describe "#valid?" do
        context "when the short_ma_period is greater than the long_ma_period" do
          let(:short_ma_period) { 60 }
          let(:long_ma_period) { 20 }

          it "returns false" do
            expect(oscillator.valid?).to eq(false)
          end
        end

        context "when the long_ma_period is greater than the series length" do
          let(:long_ma_period) { 100 }

          it "returns false" do
            expect(oscillator.valid?).to eq(false)
          end
        end

        context "when the short_ma_period is less than the long_ma_period and the long_ma_period is less than the series length" do
          it "returns true" do
            expect(oscillator.valid?).to eq(true)
          end
        end
      end
    end

    describe "secondary series" do
      series = [17_604, 18_918, 21_030, 13_854, 10_866, 14_580]
      short_ma_period = 2
      long_ma_period = 5

      expected_value = -19.73

      it "returns the expected value" do
        expect(
          described_class.new(
            series: series,
            short_ma_period: short_ma_period,
            long_ma_period: long_ma_period
          ).call
        ).to eq(expected_value)
      end
    end
  end
end
