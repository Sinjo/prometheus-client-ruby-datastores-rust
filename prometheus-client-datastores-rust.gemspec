# frozen_string_literal: true

require_relative "lib/prometheus/client/data_stores/rust/version"

Gem::Specification.new do |spec|
  spec.name = "prometheus-client-datastores-rust"
  spec.version = Prometheus::Client::DataStores::Rust::VERSION
  spec.authors = ["Chris Sinjakli"]
  spec.email = ["chris@sinjakli.co.uk"]

  spec.license = "Apache-2.0"

  spec.summary = "Rust datastores for the Ruby Prometheus client"
  spec.homepage = "https://github.com/Sinjo/prometheus-client-ruby-datastores-rust"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/Sinjo/prometheus-client-ruby-datastores-rust/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rutie", "~> 0.0.4"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
