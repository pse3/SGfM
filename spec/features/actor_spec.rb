require 'spec_helper'

Capybara.match = :first

describe "actor spec" do

  before do
    visit '/'
    click_link("Sign up")
    within('#new_login') do
      fill_in 'login_email', :with => 'test_12@test.de'
      fill_in 'login_password', :with => '1234test'
      fill_in 'login_password_confirmation', :with => '1234test'
      click_button 'Sign up'
    end
  end

  context "with full information" do
    it "creates new doctor",:js => true do

      find('div')['#accordion-inner'].click_link("Next")
      #within('#actor-type') do
      #  click_link 'Next'
      #end
      select('gynecologist', :from => 'actor_information_medical_specialisations')
      #fill_in "actor_information_first_name", :with => 'TestFirstname'
      #fill_in "actor_information_last_name", :with => 'TestLastname'
      #fill_in "actor_information_street", :with => 'TestStreet'
      #fill_in "actor_information_street_number", :with => '666'
      #fill_in "actor_information_zip", :with => '9032'
      #click_button 'Next'
      #click_button 'Create'
      #page.should contain("alert alert-success fade in")
    end
  end
end
