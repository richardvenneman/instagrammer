# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "instagrammer/version"

Gem::Specification.new do |spec|
  spec.name          = "instagrammer"
  spec.version       = Instagrammer::VERSION
  spec.authors       = ["Richard Venneman"]
  spec.email         = ["richardvenneman@me.com"]
  spec.license       = "MIT"

  spec.summary       = "Instagrammer lets you fetch Instagram user info and posts"
  spec.homepage      = "https://github.com/richardvenneman/instagrammer"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/richardvenneman/instagrammer"
  spec.metadata["changelog_uri"] = "https://github.com/richardvenneman/instagrammer/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara", "~> 3.24"
  spec.add_dependency "webdrivers", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "guard", "~> 2.15"
  spec.add_development_dependency "guard-minitest", "~> 2.4"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rubocop-rails_config", "~> 0.6"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
