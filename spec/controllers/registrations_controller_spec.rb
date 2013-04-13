require 'spec_helper'


describe RegistrationsController, 'Create a new Login' do

  # This is needed to test devise controllers
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:login]
  end

  it 'should pass arguments'  #todo this fails
    #post 'create', {:login => {:email => 'email@domain.ch', :password => 'test1234', :password_confirmation => 'test1234'}}
    #subject.current_login.account_type.should eql 'User'
    #subject.current_login.account.should_not be_nil
    #subject.current_login.account.should be_kind_of(User)

end

