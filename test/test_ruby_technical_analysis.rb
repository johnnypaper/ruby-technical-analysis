# frozen_string_literal: true

require_relative "test_helper"

class TestRubyTechnicalAnalysis < Minitest::Test
  def test_has_version_number
    refute_nil ::RubyTechnicalAnalysis::VERSION
  end

  def test_mean
    assert_equal RTA::StatisticalMethods.new([0, 1, 2, 3]).mean, 1.5
    assert_equal RTA::StatisticalMethods.new([-1, 1, 2, -2]).mean, 0
    assert_equal RTA::StatisticalMethods.new([0, 0]).mean, 0
    assert_equal RTA::StatisticalMethods.new([0]).mean, 0
  end

  def test_variance
    assert_equal RTA::StatisticalMethods.new([0, 1, 2, 3]).variance, 1.25
    assert_equal RTA::StatisticalMethods.new([-1, 1, 2, -2]).variance, 2.5
    assert_equal RTA::StatisticalMethods.new([0, 0]).variance, 0
    assert_equal RTA::StatisticalMethods.new([0]).variance, 0
  end

  def test_standard_deviation
    assert_equal RTA::StatisticalMethods.new([0, 1, 2, 3]).standard_deviation.truncate(5), 1.11803
    assert_equal RTA::StatisticalMethods.new([-1, 1, 2, -2]).standard_deviation.truncate(5), 1.58113
    assert_equal RTA::StatisticalMethods.new([0, 0]).standard_deviation.truncate(5), 0
    assert_equal RTA::StatisticalMethods.new([0]).standard_deviation.truncate(5), 0
  end

  def test_sma
    case_one = [25.000, 24.875, 24.781, 24.594, 24.500]
    case_two = [25.000, 24.875, 24.781, 24.594, 24.500, 24.625]

    assert_equal RTA::MovingAverages.new(case_one).sma(1).truncate(3), 24.500
    assert_equal RTA::MovingAverages.new(case_one).sma(5).truncate(3), 24.750
    assert_equal RTA::MovingAverages.new(case_two).sma(5).truncate(3), 24.675
  end

  def test_ema
    case_one = [25.000, 24.875, 24.781, 24.594, 24.5]
    case_two = [25.000, 24.875, 24.781, 24.594, 24.5, 24.625]

    assert_equal RTA::MovingAverages.new(case_one).ema(5).round(3), 24.698
    assert_equal RTA::MovingAverages.new(case_two).ema(5).round(3), 24.657
  end

  def test_wma
    case_one = [25.000, 24.875, 24.781, 24.594, 24.5]
    case_two = [25.000, 24.875, 24.781, 24.594, 24.5, 24.625]

    assert_equal RTA::MovingAverages.new(case_one).wma(1).round(4), 24.5000
    assert_equal RTA::MovingAverages.new(case_one).wma(5).round(4), 24.6646
    assert_equal RTA::MovingAverages.new(case_two).wma(5).round(4), 24.6229
  end

  def test_bollinger_bands
    case_one = [31.8750, 32.1250, 32.3125, 32.1250, 31.8750]
    case_two = [31.8750, 32.1250, 32.3125, 32.1250, 31.8750, 32.3125]

    assert_equal RTA::BollingerBands.new(case_one, 5).call, [32.397, 32.062, 31.727]
    assert_equal RTA::BollingerBands.new(case_two, 5).call, [32.508, 32.15, 31.791]
  end

  def test_chaikin_money_flow
    case_one = [[8.6250, 8.3125, 8.6250, 4494], [8.6250, 8.4375, 8.5000, 2090], [8.6250, 8.4375, 8.6250, 1306],
                [8.7500, 8.6250, 8.7500, 4242], [8.7500, 8.4375, 8.5000, 2874]]
    case_two = [[8.6250, 8.3125, 8.6250, 4494], [8.6250, 8.4375, 8.5000, 2090], [8.6250, 8.4375, 8.6250, 1306],
                [8.7500, 8.6250, 8.7500, 4242], [8.7500, 8.4375, 8.5000, 2874], [8.5625, 8.5000, 8.5000, 598]]

    assert_equal RTA::ChaikinMoneyFlow.new(case_one, 5).call.truncate(5), 0.50786
    assert_equal RTA::ChaikinMoneyFlow.new(case_two, 5).call.truncate(5), 0.22763
  end

  def test_chande_momentum_oscillator
    case_one = [51.0625, 50.1250, 52.3125, 52.1875, 53.1875, 53.0625]
    case_two = [51.0625, 50.1250, 52.3125, 52.1875, 53.1875, 53.0625, 54.0625]
    case_three = [51.0625, 50.1250, 52.3125, 52.1875, 53.1875, 53.0625, 54.0625, 53.5000]
    case_four = [51.0625, 50.1250, 52.3125, 52.1875, 53.1875, 53.0625, 54.0625, 53.5000, 51.5625]

    assert_equal RTA::ChandeMomentumOscillator.new(case_one, 5).call.truncate(4), 45.7143
    assert_equal RTA::ChandeMomentumOscillator.new(case_two, 5).call.truncate(4), 88.7324
    assert_equal RTA::ChandeMomentumOscillator.new(case_three, 5).call.truncate(4), 42.2222
    assert_equal RTA::ChandeMomentumOscillator.new(case_four, 5).call.truncate(4), -13.5135
  end

  def test_commodity_channel_index
    case_one = [[15.1250, 14.9360, 14.9360], [15.0520, 14.6267, 14.7520], [14.8173, 14.5557, 14.5857],
                [14.6900, 14.4600, 14.6000], [14.7967, 14.5483, 14.6983], [14.7940, 13.9347, 13.9460],
                [14.0930, 13.8223, 13.9827], [14.7000, 14.0200, 14.4500], [14.5255, 14.2652, 14.3452]]
    case_two = [[15.1250, 14.9360, 14.9360], [15.0520, 14.6267, 14.7520], [14.8173, 14.5557, 14.5857],
                [14.6900, 14.4600, 14.6000], [14.7967, 14.5483, 14.6983], [14.7940, 13.9347, 13.9460],
                [14.0930, 13.8223, 13.9827], [14.7000, 14.0200, 14.4500], [14.5255, 14.2652, 14.3452],
                [14.6579, 14.3773, 14.4197]]

    assert_equal RTA::CommodityChannelIndex.new(case_one, 5).call.truncate(4), 18.0890
    assert_equal RTA::CommodityChannelIndex.new(case_two, 5).call.truncate(4), 84.4605
  end

  def test_envelopes_ema
    case_one = [25.000, 24.875, 24.781, 24.594, 24.5]
    case_two = [25.000, 24.875, 24.781, 24.594, 24.5, 24.625]

    assert_equal RTA::EnvelopesEma.new(case_one, 5, 20).call, [29.637, 24.698, 19.758]
    assert_equal RTA::EnvelopesEma.new(case_two, 5, 20).call, [29.588, 24.657, 19.725]
  end

  def test_intraday_momentum_index
    case_one = [[18.4833, 18.5000], [18.5417, 18.4167], [18.4167, 18.1667], [18.1667, 18.1250], [18.1667, 17.9583],
                [18.0417, 18.0000], [18.0000, 17.9583], [17.9167, 17.8333], [17.7917, 17.9583]]
    case_two = [[18.4833, 18.5000], [18.5417, 18.4167], [18.4167, 18.1667], [18.1667, 18.1250], [18.1667, 17.9583],
                [18.0417, 18.0000], [18.0000, 17.9583], [17.9167, 17.8333], [17.7917, 17.9583], [18.0417, 18.5417]]

    assert_equal RTA::IntradayMomentumIndex.new(case_one, 7).call, 19.9880
    assert_equal RTA::IntradayMomentumIndex.new(case_two, 7).call, 61.5228
  end

  def test_macd
    case_one = [166.23, 164.51, 162.41, 161.62, 159.78, 159.69, 159.22, 170.33,
                174.78, 174.61, 175.84, 172.90, 172.39, 171.66, 174.83, 176.28,
                172.12, 168.64, 168.88, 172.79, 172.55, 168.88, 167.30, 164.32,
                160.07, 162.74, 164.85, 165.12, 163.20, 166.56, 166.23, 163.17,
                159.30, 157.44, 162.95]

    assert_equal RTA::Macd.new(case_one).call, [-1.934, -1.664, -0.27]
    assert_equal RTA::Macd.new(case_one, 12, 26, 9).call, [-1.934, -1.664, -0.27]
  end

  def test_mass_index
    case_one = [[38.1250, 37.7500], [38.0000, 37.7500], [37.9375, 37.8125], [37.8750, 37.6250], [38.1250, 37.5000],
                [38.1250, 37.5000], [37.7500, 37.5000], [37.6250, 37.4375], [37.6875, 37.3750], [37.5000, 37.3750],
                [37.5625, 37.3750], [37.6250, 36.8125], [36.6875, 36.3125], [36.8750, 36.2500], [36.9375, 36.5000],
                [36.5000, 36.2500], [36.9375, 36.3125], [37.0000, 36.6250], [36.8750, 36.5625]]
    case_two = [[38.1250, 37.7500], [38.0000, 37.7500], [37.9375, 37.8125], [37.8750, 37.6250], [38.1250, 37.5000],
                [38.1250, 37.5000], [37.7500, 37.7500], [37.6250, 37.4375], [37.6875, 37.3750], [37.7500, 37.3750],
                [37.5625, 37.3750], [37.6250, 36.8125], [36.6875, 36.3125], [36.8750, 36.2500], [36.9375, 36.5000],
                [36.5000, 36.2500], [36.9375, 36.3125], [37.0000, 36.6250], [36.8750, 36.5625], [36.8125, 36.3750]]

    assert_equal RTA::MassIndex.new(case_one, 9).call, 3.2236
    assert_equal RTA::MassIndex.new(case_two, 9).call, 3.1387
  end

  def test_pivot_points
    # Used Aapl monthly data from Feb 2022 to confirm pivots for March 2022
    case_one = [176.65, 152.00, 165.12]

    assert_equal RTA::PivotPoints.new(case_one).call, [127.88, 139.94, 152.53, 164.59, 177.18, 189.24, 201.83]
  end

  def test_price_channel
    case_one = [[2.8097, 2.8437], [2.9063, 2.8543], [2.8750, 2.8333], [2.8543, 2.8127], [2.9740, 2.8647],
                [3.0730, 2.9793]]
    case_two = [[2.8097, 2.8437], [2.9063, 2.8543], [2.8750, 2.8333], [2.8543, 2.8127], [2.9740, 2.8647],
                [3.0730, 2.9793], [3.1563, 3.0937]]

    assert_equal RTA::PriceChannel.new(case_one, 5).call, [2.9740, 2.8127]
    assert_equal RTA::PriceChannel.new(case_two, 5).call, [3.0730, 2.8127]
  end

  def test_q_stick
    case_one = [[62.5625, 64.5625], [64.6250, 64.1250], [63.5625, 64.3125], [63.9375, 64.8750]]
    case_two = [[62.5625, 64.5625], [64.6250, 64.1250], [63.5625, 64.3125], [63.9375, 64.8750], [64.5000, 65.1875]]

    assert_equal RTA::QStick.new(case_one, 4).call, 0.7969
    assert_equal RTA::QStick.new(case_two, 4).call, 0.4688
  end

  def test_rate_of_change
    case_one = [5.5625, 5.3750, 5.3750, 5.0625]
    case_two = [5.5625, 5.3750, 5.3750, 5.0625, 5.1094]

    assert_equal RTA::RateOfChange.new(case_one, 3).call, -8.99
    assert_equal RTA::RateOfChange.new(case_two, 3).call, -4.94
  end

  def test_relative_momentum_index
    case_one = [6.8750, 6.9375, 6.8125, 6.6095, 6.7345, 6.6720, 6.6250, 6.6875, 6.5470, 6.6563, 6.6720, 6.6563]
    case_two = [6.8750, 6.9375, 6.8125, 6.6095, 6.7345, 6.6720, 6.6250, 6.6875, 6.5470, 6.6563, 6.6720, 6.6563, 6.5938]
    assert_equal case_one.relative_momentum_index(4, 8), 13.1179
    assert_equal case_two.relative_momentum_index(4, 8), 17.7112
  end

  def test_relative_strength_index
    case_one = [37.8750, 39.5000, 38.7500, 39.8125, 40.0000, 39.8750]
    case_two = [37.8750, 39.5000, 38.7500, 39.8125, 40.0000, 39.8750, 40.1875]
    assert_equal case_one.rsi(5), 76.6667
    assert_equal case_two.rsi(5), 78.8679
  end

  def test_stochastic_oscillator
    case_one = [[34.3750, 33.5312, 34.3125], [34.7500, 33.9062, 34.1250], [34.2188, 33.6875, 33.7500],
                [33.8281, 33.2500, 33.6406], [33.4375, 33.0000, 33.0156], [33.4688, 32.9375, 33.0469],
                [34.3750, 33.2500, 34.2969], [34.7188, 34.0469, 34.1406], [34.6250, 33.9375, 34.5469]]
    case_two = [[34.3750, 33.5312, 34.3125], [34.7500, 33.9062, 34.1250], [34.2188, 33.6875, 33.7500],
                [33.8281, 33.2500, 33.6406], [33.4375, 33.0000, 33.0156], [33.4688, 32.9375, 33.0469],
                [34.3750, 33.2500, 34.2969], [34.7188, 34.0469, 34.1406], [34.6250, 33.9375, 34.5469],
                [34.9219, 34.0625, 34.3281]]
    assert_equal case_one.stochastic_oscillator(5, 3, 3), 55.4100
    assert_equal case_two.stochastic_oscillator(5, 3, 3), 70.7715
  end

  def test_volume_oscillator
    case_one = [17_604, 18_918, 21_030, 13_854, 10_866]
    case_two = [17_604, 18_918, 21_030, 13_854, 10_866, 14_580]
    assert_equal case_one.volume_oscillator(2, 5), -24.88
    assert_equal case_two.volume_oscillator(2, 5), -19.73
  end

  def test_volume_rate_of_change
    case_one = [9_996, 12_940, 37_524, 21_032, 14_880, 21_304]
    case_two = [9_996, 12_940, 37_524, 21_032, 14_880, 21_304, 15_776]
    assert_equal case_one.volume_rate_of_change(5), 113.1253
    assert_equal case_two.volume_rate_of_change(5), 21.9165
  end

  def test_wilders_smoothing
    case_one = [62.1250, 61.1250, 62.3438, 65.3125, 63.9688, 63.4375]
    case_two = [62.1250, 61.1250, 62.3438, 65.3125, 63.9688, 63.4375, 63.0000]
    assert_equal case_one.wilders_smoothing(5).truncate(4), 63.0675
    assert_equal case_two.wilders_smoothing(5).truncate(4), 63.0540
  end

  def test_williams_percent_r
    case_one = [[631.34, 624.81, 626.01], [627.11, 623.59, 626.44], [628.49, 621.33, 622.20],
                [630.89, 622.20, 630.80], [632.85, 630.21, 632.85]]
    case_two = [[631.34, 624.81, 626.01], [627.11, 623.59, 626.44], [628.49, 621.33, 622.20],
                [630.89, 622.20, 630.80], [632.85, 630.21, 632.85], [633.26, 629.64, 633.06]]
    assert_equal case_one.williams_percent_r(5), 0.00
    assert_equal case_two.williams_percent_r(5), -1.68
  end
end
