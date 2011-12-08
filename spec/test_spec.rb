require 'spec_helper'

describe Everqueen::Test do
  let(:suite) { Everqueen::Suite.new }
  subject { Everqueen::Test.new(suite, 'testing_test.js') }

  its(:name) { should == 'testing_test.js' }
  its(:root) { should == File.expand_path('suite1', File.dirname(__FILE__)) }
  its(:full_path) { should == File.expand_path("test/javascripts/testing_test.js", Everqueen.root) }
  its(:url) { should == "/run/testing_test.js" }

  context "with existing test file" do
    it { should exist }
  end

  context "with missing test file" do
    subject { Everqueen::Test.new(suite, 'does_not_exist.js') }
    it { should_not exist }
  end

end
