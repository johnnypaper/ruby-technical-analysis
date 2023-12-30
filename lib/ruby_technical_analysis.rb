# Base class
require "ruby_technical_analysis/indicator"

# Indicators
# This will require all files in the indicators directory
Dir.glob("**/indicators/*.rb") do |file|
  require file.partition("lib/").last
end
