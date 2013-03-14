class ActorTypeController < ApplicationController

  # Creates an ActorType with chosen name and InformationTypes
  def create
    @actor_type = ActorType.new
    @actor_type.key = params[:actor_type][:key]
    @actor_type.name = params[:actor_type][:name]

    for info_type in InformationType.each do
      if params[:actor_type][info_type.name] == 1
        @actor_type.information_type.push(info_type)
      end
    end

    @actor_type.save
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
end