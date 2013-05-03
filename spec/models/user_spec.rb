require 'spec_helper'

describe User do
  before do
    #create login
    @login = Login.new

    #create user
    @user = User.new
    @user.login = @login
  end

  it 'knows its user type' do
    expect(@user.user_type).to eq('User')
  end

end