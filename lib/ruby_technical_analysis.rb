# Base class
require "ruby_technical_analysis/indicator"

# Indicators
# This will require all files in the indicators directory
Dir.glob("lib/ruby_technical_analysis/indicators/*.rb") do |file|
  require file.partition("lib/").last
end
