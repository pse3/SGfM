class RegistrationsController < Devise::RegistrationsController
  # To change this template use File | Settings | File Templates.
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
    current_login.account=User.new
  end
end