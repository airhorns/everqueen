# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'everblue/version'

Gem::Specification.new do |s|
  s.name = "everblue"
  s.rubyforge_project = "everblue"
  s.version = Everblue::VERSION

  s.authors = ["Jonas Nicklas"]
  s.email = ["jonas.nicklas@gmail.com"]
  s.description = "Run Jasmine JavaScript unit tests, integrate them into Ruby applications."

  s.files = Dir.glob("{bin,lib,spec,config}/**/*") + %w(README.rdoc)
  s.extra_rdoc_files = ["README.rdoc"]
  s.executables = ['everblue']

  s.homepage = "http://github.com/jnicklas/everblue"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.6"
  s.summary = "Run Jasmine JavaScript unit tests, integrate them into Ruby applications."

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
