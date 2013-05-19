class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :set_locale

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def after_sign_in_path_for(login)
    '/' + I18n.locale.to_s + '/'
  end

  def reset_all
    load './config/initializers/mongoid.rb'
    redirect_to '/'
  end


  helper_method :current_actor, :current_account

  private

  def current_actor
    @current_actor
  end

  def current_account
    current_login.nil? ? nil : current_login.account
  end

  def authenticate_admin!
    unless current_login.account_type == 'Admin'
      flash[:error] = t('flash.no_admin_rights')
      redirect_to(home_path)
    end
  end

  def owns_actor_or_is_admin!
    unless Actor.find_by(:id => (params[:id].nil? ? params[:actor] : params[:id]) ).owner == current_account or current_login.is_admin?
      flash[:error] = t('flash.not_owner_of_actor')
      redirect_to(home_path)
    end
  end

  def owns_relationship_or_is_admin!
    unless Relationship.find_by(:id => params[:id]).actor.owner == current_account or current_login.is_admin?
      flash[:error] = t('flash.not_owner_of_relationship')
      redirect_to(home_path)
    end
  end

  # Returns true if login owns actor, false if login doesn't own actor or if login is nil.
  def login_owns_actor(login, actor)
    if login.nil?
      false
    elsif login.is_user?
      login.account.actors.include?(actor)
    else
      false
    end
  end

  # Returns true if login is admin, false if login is not admin or if login is nil.
  def is_admin(login)
    if login.nil?
      false
    else
      login.is_admin?
    end
  end

end
