Gem::Specification.new do |spec|
  spec.name = "ruby-technical-analysis"
  spec.version = "1.0.1"
  spec.authors = ["Brad Saterfiel"]
  spec.email = ["brad.saterfiel@gmail.com"]
  spec.description = "Technical analysis toolkit for stocks, commodities, and other time series written in Ruby."
  spec.summary = "Technical analysis toolkit for stocks, commodities, and other time series written in Ruby."
  spec.homepage = "https://github.com/johnnypaper/ruby-technical-analysis"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"
  spec.files = Dir["{spec,lib}/**/*.*"]
  spec.require_path = "lib"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/johnnypaper/ruby-technical-analysis"
  spec.metadata["changelog_uri"] = "https://github.com/johnnypaper/ruby-technical-analysis/blob/master/CHANGELOG.md"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9"
end
