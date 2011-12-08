require 'spec_helper'

describe Everblue::Runner do
  let(:suite) { Everblue::Suite.new }
  subject { Everblue::Test.new(suite, template) }

  context "with standard setup" do
    before { Everblue.root = File.expand_path('suite1', File.dirname(__FILE__)) }

    context "with transactions test" do
      let(:template) { 'transactions_test.js' }
      it { should pass }
    end

    context "with test helper" do
      let(:template) { 'with_helper_test.js' }
      it { should pass }
    end

    context "with slow failing test" do
      let(:template) { 'slow_test.coffee' }
      it { should_not pass }
    end
  end

  context "with modified setup" do
    before { Everblue.root = File.expand_path('suite2', File.dirname(__FILE__)) }

    context "with awesome test" do
      let(:template) { 'awesome_test.js' }
      it { should pass }
    end

    context "with failing test" do
      let(:template) { 'failing_test.js' }
      it { should_not pass }
    end
  end
end

