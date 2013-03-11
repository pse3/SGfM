require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  describe 'Create a new Login' do
    fixtures :logins
    it 'should pass arguments' do
      post 'create', :login => {:email => 'test@myTest.ch', :password => 'test1234', :password_confirmation => 'test1234'}
      assigns[:login].should be_new_record
    end
  end
end