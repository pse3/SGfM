require 'spec_helper'

# refactoring!
# page.should have_selector with different languages to Test Helper!

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

  describe "Sign up" do
    before {visit '/signup'}

    it "should have Email, PW and confirmation" do
      page.should have_selector('label', text: 'Email')
      page.should have_selector('label', text: 'Password')
      page.should have_selector('label', text: 'Password confirmation')
    end
    it "should have links to every language" do
      page.should have_selector('a', text: 'de')
      page.should have_selector('a', text: 'fr')
      page.should have_selector('a', text: 'it')
      page.should have_selector('a', text: 'en')
    end
  end

  describe "Login" do
    before {visit '/login'}

    it "should have Email, PW and confirmation" do
      page.should have_selector('label', text: 'Email')
      page.should have_selector('label', text: 'Password')
    end
    it "should have links to every language" do
      page.should have_selector('a', text: 'de')
      page.should have_selector('a', text: 'fr')
      page.should have_selector('a', text: 'it')
      page.should have_selector('a', text: 'en')
    end
  end
end