class InformationTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!

	# Creates an InformationType with chosen name
  def create
    @information_type = InformationType.new
    @information_type.key = params[:information_type][:key]
    @information_type.name = params[:information_type][:name]
		unless params[:information_type][:predefined_scope].empty?
			@information_type.predefined_scope =  Scope.find_by(key: params[:information_type][:predefined_scope])
		end
    @information_type.save

    flash[:success] = t('information_type.create.success')
    redirect_to information_types_path
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

  #todo update

end