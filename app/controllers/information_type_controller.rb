class InformationTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!

	# Creates an InformationType with chosen name
  def create
    @information_type = InformationType.new
    @information_type.key = params[:information_type][:key]
    @information_type.name = params[:information_type][:name]
    @information_type.save
  end

  # Gets all information_types
  # If there are none, return an empty array
  def list
    @information_types = InformationType.all
    if @information_types.nil?
      return Array.new
    end
  end

  # Find information_type with given id
  def show
    @information_type = InformationType.find(params[:id])
  end

  # Does nothing
  def new
  end

end