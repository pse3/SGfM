class InvitationController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!

  def list_invited

  end

  def list_uninvited
    @actors = Actor.all.select { |actor| actor.owner.nil? }
  end

  def invite
    params[:invitations].each_key do |actor_id_to_invite|
      actor = Actor.find(actor_id_to_invite)
      user = User.new
      login = Login.new
      login.email = actor.find_information_by_key(:email).value
      random_password = Login.send(:generate_token, 'encrypted_password').slice(0, 8)
      login.password = random_password
      login.account = user
      user.login = login
      user.actors.push actor

      # Send change notification (Ensure you have created #{model}Mailer e.g. UserMailer)
      #model_mailer = DeviseMailer.new
      #model_mailer.invitation(login).deliver

      login.save!
      actor.save!
      user.save!

    end
  end

end