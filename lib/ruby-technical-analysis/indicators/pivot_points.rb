# frozen_string_literal: true

# Pivot Points indicator
# Returns an array of the current pivot points for the provided H, L, C array
module PivotPoints
  def pivot_points
    h = at(0)
    l = at(1)
    c = at(2)
    pp = ((h + l + c) / 3.0).round(2)
    r1 = ((pp * 2) - l).round(2)
    s1 = ((pp * 2) - h).round(2)
    r2 = (pp + (h - l)).round(2)
    s2 = (pp - (h - l)).round(2)
    r3 = (h + (2 * (pp - l))).round(2)
    s3 = (l - (2 * (h - pp))).round(2)
    [s3, s2, s1, pp, r1, r2, r3]
  end
end

class Array
  include PivotPoints
end
