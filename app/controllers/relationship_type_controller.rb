class RelationshipTypeController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!


  def create
    relationship_type = RelationshipType.new
    relationship_type.key = params[:relationship_type][:name][:en].downcase.tr(' ', '_')
    relationship_type.name_translations = params[:relationship_type][:name]
    relationship_type.save

    flash[:success] = t('relationship_type.create.success')
    redirect_to relationship_types_path
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