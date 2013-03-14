
class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :set_locale


  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def after_sign_in_path_for(login)
    '/logins/show'
  end

  def reset_all

    load './config/initializers/mongoid.rb'

    redirect_to '/'
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
