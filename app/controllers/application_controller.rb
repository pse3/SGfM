class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(login)
    '/logins/show'
  end

  helper_method :current_actor, :current_actor=

  private
  def current_actor=(actor)
    @current_actor =actor
  end

  def current_actor
    @current_actor
  end
end
