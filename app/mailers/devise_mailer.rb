class DeviseMailer < Devise::Mailer

  def invitation(record, opts={})
    devise_mail(record, :invitation, opts)
  end

end