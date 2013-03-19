class RelationshipTypeController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!


  def create

  end

  def list
    @relationship_types = RelationshipType.all
    if @relationship_types.nil?
      return Array.new
    end
  end

  def show

  end

  def update

  end

end