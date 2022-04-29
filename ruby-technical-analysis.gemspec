# frozen_string_literal: true

require_relative "lib/ruby-technical-analysis/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-technical-analysis"
  spec.version = RubyTechnicalAnalysis::VERSION
  spec.authors = ["Brad Saterfiel"]
  spec.email = ["brad.saterfiel@gmail.com"]

  spec.summary = "Lightweight and flexible technical analysis toolkit for Ruby."
  spec.homepage = "https://rubytechnicalanalysis.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/johnnypaper/ruby-technical-analysis"
  spec.metadata["changelog_uri"] = "https://github.com/johnnypaper/ruby-technical-analysis/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
