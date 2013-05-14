require 'spec_helper'

describe Login do
  before do
    #create login
    @login_user = Login.new
    @login_admin = Login.new

    #create user
    @user = User.new
    @user.login = @login_user

    #create admin
    @admin = Admin.new
    @admin.login = @login_admin
  end

  describe ".is_user?" do
    it 'recognizes user as user' do
      @login_user.is_user?.should be_true
    end
    it 'doesnt recognize admin as user' do
      @login_admin.is_user?.should be_false
    end
  end

  describe ".is_admin?" do
    it 'doesnt recognize user as admin' do
      @login_user.is_admin?.should be_false
      end
    it 'recognizes admin as admin' do
      @login_admin.is_admin?.should be_true
    end

  end
end