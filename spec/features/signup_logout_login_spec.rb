require 'spec_helper'

#todo do we really need feature tests?
=begin
describe "User Creation" do

  describe "Sign Up" do


    before do
      visit '/signup'
      within(".form-horizontal") do
          fill_in "login[email]",    with: "testuser@bluewin.ch"
          fill_in "login[password]", with: "foofoofoo"
          fill_in "login[password_confirmation]", with: "foofoofoo"
          click_button 'Sign up'
      end
    end

    it "should create a user" do
      page.should have_selector('a', text: 'sign out')
      #TODO: it should have de fr it en
    end

    it "should log out" do
      click_link 'Sign out'
      page.should have_selector('h1', text: 'Home')
    end

    it "should log in" do
      within(".navbar-form form-inline pull-right") do
        fill_in "login[email]",    with: "testuser@bluewin.ch"
        fill_in "login[password]", with: "foofoofoo"
        click_button 'Sign up'
      end

      page.should have_content("Signed in successfully.")

    end


  end

end
=end