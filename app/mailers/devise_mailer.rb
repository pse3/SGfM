class DeviseMailer < Devise::Mailer
  protected


  def devise_mail(*args)
    super
  end

  def invitation(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome!")
  end

end