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
      page.should have_selector('a', text: 'Sign out')
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
      page.should_not have_selector('a', text: 'Sign out')
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
      page.should_not have_selector('a', text: 'Sign out')
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
      page.should_not have_selector('a', text: 'Sign out')
    end
  end

  context "with already taken email address" do
    it "does not create a new user" do
      within('#new_login') do
        fill_in 'login_email', :with => 'test@test.de'
        fill_in 'login_password', :with => '1234test'
        fill_in 'login_password_confirmation', :with => '1234test'
        click_button 'Sign up'
      end
      page.should have_selector('a', text: 'Sign out')
      click_on 'Sign out'
      click_on 'Sign up'
      within('#new_login') do
        fill_in 'login_email', :with => 'test@test.de'
        fill_in 'login_password', :with => '1234t3est'
        fill_in 'login_password_confirmation', :with => '1234t3est'
        click_button 'Sign up'
      end
      page.should_not have_selector('a', text: 'Sign out')
    end
  end
end