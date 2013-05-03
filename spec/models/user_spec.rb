require 'spec_helper'

describe User do
  before do
    #create login
    @login = Login.new

    #create user
    @user = User.new
    @user.login = @login
  end

  subject{@user}

  it{should_not be_nil}
  it{should respond_to(:login)}
  it{should respond_to(:actors)}

  it 'knows its user type' do
    expect(@user.user_type).to eq('User')
  end
end