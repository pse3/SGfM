# Controller that takes care of register process for new Users.
# Mediates inputs and converts them to commands for the model-class and the view.
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