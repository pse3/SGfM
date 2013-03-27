class ActorTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!
  #TODO refactoorrrrr
	# Creates an ActorType with chosen name and InformationTypes
  def create
    @actor_type = ActorType.new
    @actor_type.key = params[:actor_type][:name][:en].downcase.tr(' ', '_')
    index = 0 #dummy variable to test functionality
    @actor_type.name_translations = params[:actor_type][:name]
    unless params[:information].nil?
      params[:information].each do |key,value|
        info_type = InformationType.find_by_key(key.to_sym)
        if value.to_i == 1
          index = index + 1
          info_type_decorator = InformationTypeDecorator.new
          info_type_decorator.actor_type = @actor_type
          info_type_decorator.information_type = info_type
          info_type_decorator.required = true
          info_type_decorator.index = index
          info_type_decorator.searchable = true
          info_type_decorator.save
        end
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
    old_information_types = @actor_type.information_type
    @actor_type.information_type = Array.new

    #the code above moves all the info_type_decs of an actor_type to separate array and then removes them from the actor_type
    #the code below adds all the info_type_decs back to the actor_type based on if they were selected in the edit view

    unless params[:information].nil?
      params[:information].each do |key,value|
        info_type = InformationType.find_by_key(key.to_sym)
        info_type_decorator = old_information_types.select{ |a| a.information_type == info_type }.first

        if info_type_decorator.nil?  #in this case info_type_decorator doesn't exists and needs creating
          info_type_decorator = InformationTypeDecorator.new
          info_type_decorator.information_type = info_type
          info_type_decorator.required = true               #todo get params here from view
          info_type_decorator.searchable = true
          info_type_decorator.index = 10
          info_type_decorator.actor_type = @actor_type

        else #in this case info_type_decorator exists already, only needs to be updated
          info_type_decorator.searchable = true #todo get params here from view
          info_type_decorator.required = true
          info_type_decorator.index = 10
          info_type_decorator.actor_type = @actor_type
        end
      end
    end

    @actor_type.save

    flash[:success] = t('actor_type.update.success')
    redirect_to actor_types_path
  end

end