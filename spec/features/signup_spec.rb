require 'spec_helper'

Capybara.match = :first

describe "Sign up" do

  before do
    visit '/'
    click_link("Sign up")
  end

  context "with correct sign up information" do
    it "creates a new user and displays new actor dialog" do
      within('#new_login') do
        fill_in 'login_email', :with => 'test@test.de'
        fill_in 'login_password', :with => '1234test'
        fill_in 'login_password_confirmation', :with => '1234test'
        click_button 'Sign up'
      end
      page.should have_content('Create new actor')
    end
  end
  context "with non-matching passwords" do
    it "does not create a new user" do
      within('#new_login') do
        fill_in 'login_email', :with => 'test@test.de'
        fill_in 'login_password', :with => '1234test'
        fill_in 'login_password_confirmation', :with => '1234test2'
        click_button 'Sign up'
      end
      page.should_not have_content('Create new actor')
    end
  end
  context "with no email address" do
    it "does not create a new user" do
      within('#new_login') do
        fill_in 'login_email', :with => ''
        fill_in 'login_password', :with => '1234test'
        fill_in 'login_password_confirmation', :with => '1234test'
        click_button 'Sign up'
      end
      page.should_not have_content('Create new actor')
    end
  end
  context "with wrong email address" do
    it "does not create a new user" do
      within('#new_login') do
        fill_in 'login_email', :with => 'test_email_wrong'
        fill_in 'login_password', :with => '1234test'
        fill_in 'login_password_confirmation', :with => '1234test'
        click_button 'Sign up'
      end
      page.should_not have_content('Create new actor')
    end
  end
  context "with already taken email address" do
    it "creates a new user and displays new actor dialog" do
      within('#new_login') do
        fill_in 'login_email', :with => 'test@test.de'
        fill_in 'login_password', :with => '1234test'
        fill_in 'login_password_confirmation', :with => '1234test'
        click_button 'Sign up'
      end
      page.should have_content('Create new actor')
    end
  end
  context "with already taken email address" do
    it "creates a new user and displays new actor dialog" do
      within('#new_login') do
        fill_in 'login_email', :with => 'test@test.de'
        fill_in 'login_password', :with => '1234test'
        fill_in 'login_password_confirmation', :with => '1234test'
        click_button 'Sign up'
      end
      page.should have_content('Create new actor')
      click_on 'Sign out'
      click_on 'Sign up'
      within('#new_login') do
        fill_in 'login_email', :with => 'test@test.de'
        fill_in 'login_password', :with => '1234t3est'
        fill_in 'login_password_confirmation', :with => '1234t3est'
        click_button 'Sign up'
      end
      page.should_not have_content('Create new actor')
    end
  end
end


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