require 'spec_helper'

describe WhitelistScope do
  before {
    #create logins
    @login_user1 = Login.new
    @login_user2 = Login.new

    #create users
    @user1 = User.new
    @user1.login = @login_user1
    @user2 = User.new
    @user2.login = @login_user2

    #create whitelist
    @whitelist = WhitelistScope.new
    list = Array.new
    list.push(@user1)
    @whitelist.list = list
  }

  it 'inherits from scope' do
    WhitelistScope.should < Scope
  end

  it 'is visible to viewers in whitelist'
  it 'isnt visible to viewers not in whitelist'

end