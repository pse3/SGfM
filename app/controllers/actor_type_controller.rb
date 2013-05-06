class ActorTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!

	# Creates an ActorType with chosen name and InformationTypes
  def create

    params[:actor_type][:key] = params[:actor_type][:name_translations][:en].downcase.tr(' ', '_')
    actor_type = ActorType.new params[:actor_type]

    if params[:information_type_decorator]
      keys = params[:information_type_decorator][:information_type]
      required = params[:information_type_decorator][:required]
      searchable = params[:information_type_decorator][:searchable]

      keys.each_with_index do |key, i|
        info_type = InformationType.find_by_key(key.to_sym)
        InformationTypeDecorator.create(info_type, actor_type, required[i], searchable[i])
      end
    end

    if params[:predefined_questions][:relationship_types]
      params[:predefined_questions][:relationship_types].each do |relationship_type|
        if relationship_type.length > 0
          actor_type.predefined_questions.push(RelationshipType.find_by :key => relationship_type)
        end
      end
    end

    if actor_type.save
      flash[:success] = t('actor_type.create.success')
      redirect_to actor_types_path
    else
      flash[:error] = t('actor_type.create.failure')
      redirect_to create_actor_type_path
    end
  end

  # Gets all actor_types
  # If there are none, return an empty array
  def list
    @actor_types = ActorType.all
    @actor_type = Array.new unless @actor_type
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
    @actor_type.to_string_pattern = params[:actor_type][:to_string_pattern]
    @actor_type.information_type_decorators = Array.new


    #the code above removes all the info_type_decs of an actor_type.doesn't delete the decorators. they are needed because
    #informations of existing actors of this actor_type still reference and need their data!!!
    #the code below adds all the info_type_decs back to the actor_type based on if they were selected in the edit view

    if params[:information_type_decorator]
      keys = params[:information_type_decorator][:information_type]
      required = params[:information_type_decorator][:required]
      searchable = params[:information_type_decorator][:searchable]
      keys.each_with_index do |key, i|
        information_type = InformationType.find_by_key(key.to_sym)
        InformationTypeDecorator.create(information_type, @actor_type, required[i], searchable[i])
      end
    end

    @actor_type.save

    flash[:success] = t('actor_type.update.success')
    redirect_to actor_types_path
  end

  def destroy
    @actor_type = ActorType.find(params[:id])
    @actors = Actor.where( :actor_type => @actor_type)
    @actor_type.destroy
    @actors.each do |actor|
      actor.destroy
    end

    flash[:success] = t('actor_type.destroy.success')
    redirect_to(actor_types_path)
  end

end