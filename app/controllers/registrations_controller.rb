class RegistrationsController < Devise::RegistrationsController



  def new
    super
  end

  def create
    super
    @user = User.new
    resource.account = @user
    @user.save
    resource.save
  end

  def update
    super
  end

end