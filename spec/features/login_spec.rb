require 'spec_helper'

Capybara.match = :first

describe "Log in" do

  before do
    visit '/'
    click_link("Sign up")
    within('#new_login') do
      fill_in 'login_email', :with => 'test@test.de'
      fill_in 'login_password', :with => '1234test'
      fill_in 'login_password_confirmation', :with => '1234test'
      click_button 'Sign up'
    end
    click_on 'Sign out'
  end

  context "with existing login" do
    it "logs in" do
      click_on 'Sign in'
      fill_in "login_email", :with => 'test@test.de'
      fill_in "login_password", :with => '1234test'
      click_button 'Sign in'
      page.should have_selector('a', text: 'Sign out')
    end
  end

  context "with non-existing login" do
    it "does not sign in" do
      click_on 'Sign in'
      fill_in "login_email", :with => 'test15@test.de'
      fill_in "login_password", :with => '1234test'
      click_button 'Sign in'
      page.should_not have_selector('a', text: 'Sign out')
    end
  end
end
