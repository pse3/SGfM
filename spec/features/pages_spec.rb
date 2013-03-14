require 'spec_helper'

describe "Application Pages" do

  describe "Home Page" do
    before { visit '/'}

    it "should have the content 'Home'" do
      page.should have_selector('h1', text: 'Home')
    end
    it "should have links to every language" do
      page.should have_selector('a', text: 'de')
      page.should have_selector('a', text: 'fr')
      page.should have_selector('a', text: 'it')
      page.should have_selector('a', text: 'en')
    end
  end
end