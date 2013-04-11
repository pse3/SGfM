class RegistrationsController < Devise::RegistrationsController

  after_filter :set_account, :only => [:create]


  def new
    super
  end

  def create
    super
  end

  def update
    super
  end

  private
  def set_account
    if login_signed_in?
      @user = User.new
      current_login.account = @user
      @user.save
      current_login.save
    end
  end

end