# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'everqueen/version'

Gem::Specification.new do |s|
  s.name = "everqueen"
  s.rubyforge_project = "everqueen"
  s.version = Everqueen::VERSION

  s.authors = ["Jonas Nicklas", "Harry Brundage"]
  s.email = ["jonas.nicklas@gmail.com", "harry.brundage@jadedpixel.com"]
  s.description = "Run QUnit JavaScript unit tests, integrate them into Ruby applications."

  s.files = Dir.glob("{bin,lib,spec,config}/**/*") + %w(README.rdoc)
  s.extra_rdoc_files = ["README.rdoc"]
  s.executables = ['everqueen']

  s.homepage = "http://github.com/hornairs/everqueen"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.6"
  s.summary = "Run QUnit JavaScript unit tests, integrate them into Ruby applications."

  s.add_runtime_dependency("capybara", ["~> 1.0"])
  s.add_runtime_dependency("launchy")
  s.add_runtime_dependency("sinatra", ["~> 1.1"])
  s.add_runtime_dependency("json_pure")
  s.add_runtime_dependency("coffee-script")
  s.add_runtime_dependency("sprockets", ["~> 2.0"])

  s.add_development_dependency('rspec', ['~> 2.0'])
  s.add_development_dependency('capybara-webkit', ['~>0.7'])
  s.add_development_dependency('therubyracer', ['~> 0.9'])
  s.add_development_dependency('rake')
end
