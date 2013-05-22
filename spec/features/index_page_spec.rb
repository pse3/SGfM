require 'spec_helper'

Capybara.match = :first

describe "Home page" do

  before do
    visit '/en/actors/search'
  end

  it "has the content 'Search'" do
    page.should have_content('Search')
  end
  it "has links to DE, FR, IT and EN" do
    page.should have_link('en')
    page.should have_link('fr')
    page.should have_link('de')
    page.should have_link('it')
  end
  it "has link to Sign in" do
    page.should have_link('Sign in')
  end
  it "has link to Sign up" do
    page.should have_link('Sign up')
  end
end