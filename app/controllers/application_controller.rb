class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :set_locale


  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def after_sign_in_path_for(login)
    '/' + I18n.locale.to_s + '/logins/show'
  end

  def reset_all
    load './config/initializers/mongoid.rb'
    redirect_to '/'
  end


  helper_method :current_actor

  private

  def current_actor
    @current_actor
  end

  def authenticate_admin!
    unless current_login.account_type == 'Admin'
      flash[:error] = t('flash.no_admin_rights')
      redirect_to(home_path)
    end
  end

  def ensure_user_owns_actor!()
    unless Actor.find_by(id: params[:id]).owner == current_login.account
      flash[:error] = t('flash.not_owner_of_actor')
      redirect_to(home_path)
    end
  end
end
