require 'spec_helper'


describe RegistrationsController, 'Create a new Login' do
  it 'should pass arguments' do
    post 'create', :login => {:email => 'test@myTest.ch', :password => 'test1234', :password_confirmation => 'test1234'}
    assigns[:login].should be_new_record
  end
end

