# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack-emoji-download/version'

Gem::Specification.new do |spec|
  spec.name          = "slack-emoji-download.rb"
  spec.version       = SlackEmojiDownload::VERSION
  spec.authors       = ["KID the Euforia"]
  spec.email         = ["kid0725@gmail.com"]

  spec.summary       = "A downloader for Slack cutom emoji."
  spec.homepage      = "https://github.com/blueberrystream/slack-emoji-download.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "thor"
end
