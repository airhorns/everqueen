require 'spec_helper'

describe Everblue::Spec do
  let(:suite) { Everblue::Suite.new }
  subject { Everblue::Spec.new(suite, 'testing_spec.js') }

  its(:name) { should == 'testing_spec.js' }
  its(:root) { should == File.expand_path('suite1', File.dirname(__FILE__)) }
  its(:full_path) { should == File.expand_path("spec/javascripts/testing_spec.js", Everblue.root) }
  its(:url) { should == "/run/testing_spec.js" }
  its(:contents) { should =~ /describe\('testing'/ }

  context "with coffeescript" do
    subject { Everblue::Spec.new(suite, 'coffeescript_spec.coffee') }
    its(:contents) { should =~ /describe\('coffeescript', function/ }
  end

  context "with existing spec file" do
    it { should exist }
  end

  context "with missing spec file" do
    subject { Everblue::Spec.new(suite, 'does_not_exist.js') }
    it { should_not exist }
  end

end
