class ActorTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!

	# Creates an ActorType with chosen name and InformationTypes
  def create
    @actor_type = ActorType.new
    @actor_type.key = params[:actor_type][:name_en].downcase.tr(' ', '_')

    temp_lang = I18n.locale
    I18n.locale = :en
    @actor_type.name = params[:actor_type][:name_en]
    I18n.locale = :de
    @actor_type.name = params[:actor_type][:name_de]
    I18n.locale = :fr
    @actor_type.name = params[:actor_type][:name_fr]
    I18n.locale = :it
    @actor_type.name = params[:actor_type][:name_it]
    I18n.locale = temp_lang

    for info_type in InformationType.each do
      if params[info_type.key].to_i == 1
        @actor_type.information_type.push(info_type)
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

    #todo update data

    @actor_type.save

    flash[:success] = t('actor_type.update.success')
    redirect_to actor_types_path
  end

end