class InvitationController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!

  def list_invited

  end

  def list_uninvited
    @actors = Actor.all.select { |actor| actor.owner.nil? }
  end

  def invite

    logins = Array.new

    failed = Array.new

    params[:invitations].each_key do |actor_id_to_invite|
      actor = Actor.find(actor_id_to_invite)
      user = User.new
      login = Login.new
      login.email = actor.find_information_by_key(:email).value
      login.password = Login.reset_password_token
      login.reset_password_token= Login.reset_password_token
      login.reset_password_sent_at = Time.now
      login.account = user
      user.login = login
      user.actors.push actor

      # confirmation email is sent automatically by saving

      if login.valid?
        login.save!
        actor.save!
        user.save!
        login.send_invitation
        logins.push login
      else
        failed.push login
      end
    end

    flash[:success] = "#{logins.length} new logins created."
    if failed.length > 0
      flash[:error] = "failed to create #{failed.length} logins."
    end
  end

end