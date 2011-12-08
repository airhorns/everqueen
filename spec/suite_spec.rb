require 'spec_helper'

describe Everqueen::Suite do
  subject { Everqueen::Suite.new }

  its(:root) { should == File.expand_path('suite1', File.dirname(__FILE__)) }

  describe '#get_test' do
    subject { Everqueen::Suite.new.get_test('testing_test.js') }
    its(:name) { should == 'testing_test.js' }
    its(:root) { should == File.expand_path('suite1', File.dirname(__FILE__)) }
  end

  describe '#tests' do
    it "should find all tests recursively in the given root directory" do
      subject.tests.map(&:name).should include('testing_test.js', 'foo_test.js', 'bar_test.js', 'libs/lucid_test.js', 'models/game_test.js')
    end
  end
end
