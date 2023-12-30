# Ruby Technical Analysis

Technical analysis toolkit for Ruby.

Codebase derived from Steven B. Achelis' *Technical Analysis from A to Z* (2nd Edition).

Test suite uses examples from the book to verify accuracy.

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

`gem install 'ruby-technical-analysis'` from the command line.

## Usage

The test suite is a great place to look at usage as well as the individual classes themselves.  Here are a couple of use cases:

```
# Bollinger Bands

series_one = [31.8750, 32.1250, 32.3125, 32.1250, 31.8750]
RubyTechnicalAnalysis::BollingerBands.call(series_one, 5)

# => [32.397, 32.062, 31.727]
```

```
# Intraday Momentum Index 

# [Open, Close]
oc_series_one = [[18.4833, 18.5000], [18.5417, 18.4167], [18.4167, 18.1667], [18.1667, 18.1250], [18.1667, 17.9583], [18.0417, 18.0000], [18.0000, 17.9583], [17.9167, 17.8333], [17.7917, 17.9583]]

RubyTechnicalAnalysis::IntradayMomentumIndex.call(oc_series_one, 7)

# => 19.988
```

## Testing

The test suite is run in Github workflows, but you can run them yourself with:

`ruby test/test_ruby_technical_analysis.rb`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
