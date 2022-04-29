# frozen_string_literal: true

# Statistical methods used in calculations
module StatisticalMethods
  def standard_deviation

    if size <= 1
      raise ArgumentError,
            "Array must contain at least 2 numbers for standard deviation."
    end

    mean = reduce(:+).to_f / size
    sq_dist = 0

    each do |n|
      sq_dist += (n - mean).abs2
    end

    Math.sqrt(sq_dist.to_f / size)
  end
end

class Array
  include StatisticalMethods
end
