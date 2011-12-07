require 'spec_helper'

describe Everblue::Application do
  include Capybara::DSL

  it "should show a successful test run" do
    visit("/")
    click_link("testing_test.js")
    page.should have_content("2 tests, 0 failures")
  end

  it "should show a successful test run for a coffeescript test" do
    visit("/")
    click_link("coffeescript_test.coffee")
    page.should have_content("2 tests, 0 failures")
  end

  it "should show errors for a failing test" do
    visit("/")
    click_link("failing_test.js")
    page.should have_content("2 tests, 1 failure")
    page.should have_content("Expected 'bar' to equal 'noooooo'.")
  end

  it "should run all tests" do
    visit("/")
    click_link("All")
    page.should have_content("18 tests, 3 failures")
    page.should have_content("Expected 'bar' to equal 'noooooo'.")
  end

  it "should run a test inline" do
    visit("/")
    within('li', :text => 'testing_test.js') do
      click_link("Run")
      page.should have_content('Pass')
    end
  end

  it "should run a failing test inline" do
    visit("/")
    within('li', :text => 'failing_test.js') do
      click_link("Run")
      begin
        page.should have_content('Fail')
      rescue # why you make me sad, Capybara webkit???
        page.should have_content('Fail')
      end
    end
  end
end
