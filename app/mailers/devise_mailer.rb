class DeviseMailer < Devise::Mailer
  protected

  def default_url_options(options={})
    { :locale => I18n.locale,
    :host => 'localhost:3000'}
  end

  def devise_mail(*args)
    default_url_options

    super
  end

  def invitation(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome!")
  end

end