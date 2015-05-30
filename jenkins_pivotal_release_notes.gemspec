# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jenkins_pivotal_release_notes/version'

Gem::Specification.new do |spec|
  spec.name          = "jenkins_pivotal_release_notes"
  spec.version       = JenkinsPivotalReleaseNotes::VERSION
  spec.authors       = ["Kenny Chapman"]
  spec.email         = ["lkchapman@gmail.com"]

  spec.summary       = %q{Pivotal Tracker release notes -> Jenkins}
  spec.description   = %q{Pivotal Tracker release notes -> Jenkins}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "slop", "~> 3.4"
  spec.add_dependency "tracker_api", "~> 0.2.0"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
