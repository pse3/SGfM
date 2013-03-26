class RelationshipController < ApplicationController

  before_filter :ensure_user_owns_actor!, :only => [:new, :create]
  before_filter :ensure_user_owns_relationship!, :only => [:edit, :update, :destroy]

  def new
    @locals = { :all_actors => Actor.all,
                :actor => Actor.find(params[:actor]) }
    # todo shouldn't we do it everywhere like this? easier to find passed variables in view and only way to pass multiple
  end

  def create
    @actor = Actor.find(params[:actor])
    relationship = Relationship.new
    relationship.actor = @actor
    relationship.reference = Actor.find(params[:relationship][:reference])
    relationship.comment = params[:relationship][:comment]
    relationship.relationship_type = RelationshipType.find_by_key(params[:relationship][:relationship_type])
    relationship.save

    flash[:success] = t('relationship.create.success')
    redirect_to(show_actor_path(@actor))
  end

  def edit
    @locals = { :relationship => Relationship.find(params[:id]),
                :all_actors => Actor.all }
  end

  def update
    relationship = Relationship.find(params[:id])
    @actor = relationship.actor
    relationship.relationship_type = RelationshipType.find_by_key(params[:relationship][:relationship_type])
    relationship.comment = params[:relationship][:comment]
    relationship.save

    flash[:success] = t('relationship.update.success')
    redirect_to(show_actor_path(@actor))
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @actor = @relationship.actor
    @relationship.destroy

    flash[:success] = t('relationship.destroy.success')
    redirect_to(show_actor_path(@actor))
  end

end