require 'spec_helper'

describe Everqueen::Runner do
  let(:suite) { Everqueen::Suite.new }
  let(:runner) { Everqueen::Runner.new(buffer) }
  let(:buffer) { StringIO.new }

  describe '#run' do
    before { runner.run }

    describe 'the buffer' do
      subject { buffer.rewind; buffer.read }

      it { should include('.F..') }
      it { should include("Expected 'noooooo', got 'bar'") }
      it { should include("10 assertions, 2 failures") }
    end
  end

  describe '#run_test' do
    let(:test) { suite.get_test('failing_test.js') }
    before { runner.test_runner(test).run }

    describe 'the buffer' do
      subject { buffer.rewind; buffer.read }

      it { should include('.F') }
      it { should include("Expected 'noooooo', got 'bar'") }
      it { should include("2 assertions, 1 failures") }
    end
  end
end
