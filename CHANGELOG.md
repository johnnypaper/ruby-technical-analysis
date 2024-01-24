# Ruby Technical Analysis

## 1.0.0 (Unreleased)

### Breaking Changes
- Previously an indicator was called on an array, e.g. `[0,1,2,3].mean`
- Now all indicators are first class, e.g. `Rta::StatisticalMethods.new(series: [0, 1, 2, 3]).mean`
  - See docs and test suite for more examples

## 0.1.0 (2022-04-29)

- Initial release
