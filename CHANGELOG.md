# Ruby Technical Analysis

## 1.0.1 (2024-01-24)

### Breaking Changes
- Previously an indicator was called on an array, e.g. `[0,1,2,3].mean`
- Now all indicators are first class, e.g. `RubyTechnicalAnalysis::StatisticalMethods.new(series: [0, 1, 2, 3]).mean`
  - See examples on GH, yard docs, and specs for more examples and information

## 0.1.0 (2022-04-29)

- Initial release
