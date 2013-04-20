class UserMailer < ActionMailer::Base
  default from: "noReply@qualitaetsmedizin.ch"


  def invitation_mail( actor, email)
    @user = actor.owner
    @name = actor.find_information_by_key(:last_name)
    mail(:to => email, :subject => l(mail.invitation))
  end

end
