# Controller for objects of class RelationshipType.
# Mediates inputs and converts them to commands for the model-class and the view.
class RelationshipTypeController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!

  def create
    params[:relationship_type][:key] = params[:relationship_type][:name_translations][:en].downcase.tr(' ', '_')
    relationship_type = RelationshipType.new params[:relationship_type]
    if relationship_type.save
      flash[:success] = t('relationship_type.create.success')
      redirect_to relationship_types_path
    else
      flash[:error] = t('relationship_type.create.failure')
      redirect_to create_relationship_path
    end
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
    @relationship_type.update_attributes(params[:relationship_type])

    if @relationship_type.save
      flash[:success] = t('relationship_type.update.success')
      redirect_to relationship_types_path
    else
      flash[:error] = t 'relationship_type.update.failure'
      redirect_to edit_relationship_type(@relationship_type)
    end
  end

  def destroy
    @relationship_type = RelationshipType.find(params[:id])
    @relationships = Relationship.where( :relationship_type => @relationship_type)
    @relationship_type.destroy
    @relationships.each do |relationship|
      relationship.destroy
    end

    flash[:success] = t('relationship_type.destroy.success')
    redirect_to(relationship_types_path)
  end

end