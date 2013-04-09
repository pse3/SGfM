require 'spec_helper'

# TODO: refactoring:
# page.should have_selector with different languages to Test Helper!
#todo do we really need feature tests?

describe "Static Pages" do

  describe "Sign up" do
    before {visit '/signup'}
    it "should have title Sign up" do
      page.should have_selector('h1', text: 'Sign up')
    end
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