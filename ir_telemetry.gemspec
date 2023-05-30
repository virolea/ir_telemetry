# frozen_string_literal: true

require_relative "lib/ir_telemetry/version"

Gem::Specification.new do |spec|
  spec.name = "ir_telemetry"
  spec.version = IRTelemetry::VERSION
  spec.authors = ["Vincent Rolea"]
  spec.email = ["low.salt3234@fastmail.com"]
  spec.license = "MIT"
  spec.summary = "Parse and browse iRacing telemetry files with Ruby."
  spec.description = "Parse and browse iRacing telemetry files with Ruby."
  spec.homepage = "https://github.com/virolea/ir_telemetry"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/virolea/ir_telemetry/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ docs/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "zeitwerk", "~> 2.6"
  spec.add_dependency "bindata", "~> 2.4"
end
