require 'spec_helper'

describe Everblue::Template do
  let(:suite) { Everblue::Suite.new }
  subject { Everblue::Template.new(suite, 'one_template.html') }

  its(:name) { should == 'one_template.html' }
  its(:root) { should == File.expand_path('suite1', File.dirname(__FILE__)) }
  its(:full_path) { should == File.expand_path("test/javascripts/templates/one_template.html", Everblue.root) }
  its(:contents) { should =~ %r(<h1 id="from\-template">This is from the template</h1>) }

  context "with existing test file" do
    it { should exist }
  end

  context "with missing test file" do
    subject { Everblue::Template.new(suite, 'does_not_exist.html') }
    it { should_not exist }
  end

end

describe Everblue::Template, "escaping" do
  let(:suite) { Everblue::Suite.new }
  subject { Everblue::Template.new(suite, 'escape.html') }

  it "escapes contents" do
    subject.escaped_contents.strip.should == %{"<scr" + "ipt>var foo = 0;</scr" + "ipt>\\n"}
  end
end
