# Ruby Technical Analysis

Ruby technical analysis toolkit for stocks, commodities, and other time series.

Codebase derived from Steven B. Achelis' *Technical Analysis from A to Z* (2nd Edition).

Specs use examples from the book to verify accuracy.

## Library
- Statistical Methods
  - Mean
  - Standard Deviation
  - Variance
- Moving Averages
  - Simple Moving Average
  - Exponential Moving Average
  - Weighted Moving Average
- Indicators
  - Bollinger Bands
  - Chaikin Money Flow
  - Chande Momentum Oscillator
  - Envelopes EMA
  - Intraday Momentum Index
  - MACD
  - Mass Index
  - Pivot Points
  - Price Channel
  - QStick
  - Rate of Change
  - Relative Momentum Index
  - Relative Strength Index
  - Stochastic Oscillator
  - Volume Oscillator
  - Wilders Smoothing
  - Williams %R

## Installation

Add this line to your Gemfile
```
gem 'ruby-technical-analysis'
```

Then run `bundle install`.

#### OR

`gem install ruby-technical-analysis` from the command line.

## Usage

Examples:

```
# Bollinger Bands

# Closing prices
series = [31.875, 32.125, 32.3125, 32.125, 31.875]

bb = RubyTechnicalAnalysis::BollingerBands.new(series: series, period: 5)

bb.valid?
# => true

bb.call
# => [32.397, 32.062, 31.727]
```

```
# Intraday Momentum Index 

# [Open, Close]
oc_series = [[18.4833, 18.5], [18.5417, 18.4167], [18.4167, 18.1667], [18.1667, 18.125], [18.1667, 17.9583], [18.0417, 18], [18, 17.9583], [17.9167, 17.8333], [17.7917, 17.9583]]

imi = RubyTechnicalAnalysis::IntradayMomentumIndex.new(series: oc_series, period: 7)

imi.valid?
# => true

imi.call
# => 19.988
```

All indicators have the `#valid?` instance method to validate the indicator prior to calling `#call`.

## Docs

Yard documentation available.

## Testing

Specs are run in Github workflows. You can run them yourself with:

`rspec spec`

## License

The gem is available open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
