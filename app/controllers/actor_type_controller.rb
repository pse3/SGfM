class ActorTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!

	# Creates an ActorType with chosen name and InformationTypes
  def create
    @actor_type = ActorType.new
    @actor_type.key = params[:actor_type][:name][:en].downcase.tr(' ', '_')
    @actor_type.name_translations = params[:actor_type][:name]

    #TODO required and searchable aren't collected correctly from form. BIATCH. info_type_decs are created but required and searchable are sett false

    unless params[:information_type_decorator].nil?
      params[:information_type_decorator][:type].each do |key, required, searchable|
        info_type = InformationType.find_by_key(key.to_sym)
        InformationTypeDecorator.create(info_type, @actor_type, 10, required, searchable)
      end

    end

    @actor_type.save

    flash[:success] = t('actor_type.create.success')
    redirect_to actor_types_path
  end

  # Gets all actor_types
  # If there are none, return an empty array
  def list
    @actor_types = ActorType.all
    if @actor_types.nil?
      return Array.new
    end
  end

  # Find information_type with given id
  def show
    @actor_type = ActorType.find(params[:id])
  end

  # Passes all information types in a list, that the user will be able to choose from
  def new
    @information_types = InformationType.all
  end

  def edit
    @actor_type = ActorType.find(params[:id])
  end

  def update
    @actor_type = ActorType.find(params[:id])
    @actor_type.name_translations = params[:actor_type][:name]
    @actor_type.information_type_decorators = Array.new

    #the code above removes all the info_type_decs of an actor_type.doesn't delete the decorators. they are needed because
    #informations still reference and need their data!!!
    #the code below adds all the info_type_decs back to the actor_type based on if they were selected in the edit view

    unless params[:information].nil?
      params[:information].each do |key,value|
        info_type = InformationType.find_by_key(key.to_sym)
        InformationTypeDecorator.create(info_type, @actor_type, 10, true, true)
      end
    end

    @actor_type.save

    flash[:success] = t('actor_type.update.success')
    redirect_to actor_types_path
  end

end