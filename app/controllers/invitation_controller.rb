class InvitationController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!

  def list_all

  end

  def list_invited

  end

  def list_invited_unresponsive

  end

  def list_uninvited

  end

  def list_uninvited_without_email

  end

  def invite

  end

  def remember

  end

end