class InformationController < ApplicationController
  before_filter :authenticate_login!

  def create
    @information = Information.new
    @information.value = params[:value]
    @information.information_type = InformationType.find_by_key(params[:key].to_sym)
    current_actor.informations.push @information
    current_actor.save
  end

  def list_informations
    @informations = current_actor.informations
  end

end