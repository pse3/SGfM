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
    @relationship_type = RelationshipType.find(params[:id])
  end

  def edit
    @relationship_type = RelationshipType.find(params[:id])
  end

  def update
    @relationship_type = RelationshipType.find(params[:id])

    #todo update data

    @relationship_type.save

    flash[:success] = t('relationship_type.update.success')
    redirect_to relationship_type_path(@relationship_type)
  end

end