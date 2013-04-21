class DeviseMailer < Devise::Mailer
  protected

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def devise_mail(*args)
    default_url_options
    super
  end
end