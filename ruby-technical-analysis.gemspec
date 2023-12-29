Gem::Specification.new do |spec|
  spec.name                   = "ruby-technical-analysis"
  spec.version                = "1.0.0"
  spec.authors                = ["Brad Saterfiel"]
  spec.email                  = ["brad.saterfiel@gmail.com"]
  spec.description            = %q{Ruby Technical Analysis}
  spec.summary                = %q{Lightweight and flexible technical analysis toolkit for Ruby.}
  spec.homepage               = "https://rubytechnicalanalysis.com"
  spec.license                = "MIT"
  spec.required_ruby_version  = ">= 3.0"
  spec.files                  = Dir["{test,lib}/**/*.*"]
  spec.require_path           = "lib"

  spec.metadata["homepage_uri"]       = spec.homepage
  spec.metadata["source_code_uri"]    = "https://github.com/johnnypaper/ruby-technical-analysis"
  spec.metadata["changelog_uri"]      = "https://github.com/johnnypaper/ruby-technical-analysis/blob/master/CHANGELOG.md"
  spec.metadata["allowed_push_host"]  = "https://rubygems.org"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
