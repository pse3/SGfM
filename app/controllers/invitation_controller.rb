# Controller that takes care of inviting Users that own Actors which have been imported..
# Mediates inputs and converts them to commands for the model-class and the view.
class InvitationController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!

  def list_invited
    @actors = Actor.all.select { |actor| actor.owner and actor.owner.login.invited and actor.owner.login.reset_password_token }
  end

  def list_uninvited
    @actors = Actor.all.select { |actor| actor.owner.nil? }
  end

  def invite

    logins = Array.new

    failed = Array.new

    params[:invitations].each_key do |actor_id_to_invite|
      actor = Actor.find(actor_id_to_invite)
      actor.invited = true
      user = User.new
      login = Login.new
      login.email = actor.find_information_by_key(:email).value
      login.password = Login.reset_password_token
      login.reset_password_token= Login.reset_password_token
      login.reset_password_sent_at = Time.now
      login.account = user
      user.login = login
      user.actors.push actor

      if login.valid?
        login.invited = true
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

  def reinvite
    params[:invitations].each_key do |actor_id_to_reinvite|
      actor = Actor.find(actor_id_to_reinvite)
      login = actor.owner.login
      login.email = actor.find_information_by_key(:email).value
      login.password = Login.reset_password_token
      login.reset_password_token = Login.reset_password_token
      login.reset_password_sent_at = Time.now

      if login.valid?
        login.save!
        login.send_invitation
      end
    end

    redirect_to invitation_list_invited_path
  end

end