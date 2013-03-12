require 'spec_helper'


describe RegistrationsController, 'Create a new Login' do

  # This is needed to test devise controllers
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:login]
  end

  it 'should pass arguments' do
    post 'create', :login => {:email => 'test@myTest.ch', :password => 'test1234', :password_confirmation => 'test1234'}
    assigns[:login].should be_new_record
  end
end

