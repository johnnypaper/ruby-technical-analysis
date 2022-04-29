# frozen_string_literal: true

Dir[File.join(__dir__, "ruby-technical-analysis/**/", "*.rb")].sort.each { |f| require f }

# module for Ruby Technical Analysis
module RubyTechnicalAnalysis
  class Error < StandardError; end
end
