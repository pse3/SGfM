class InformationTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!

	# Creates an InformationType with chosen name
  def create
    information_type = InformationType.new
    information_type.name_translations = params[:information_type][:name]
    information_type.key = params[:information_type][:key]
    if params[:information_type][:scope].size > 0
			information_type.scope =  Scope.find_by key: params[:information_type][:scope]
    end
    information_type.information_field_type= InformationFieldType.find_by_key params[:information_type][:information_field_type]
    #TODO make the view receive the data form via ajax so it is only displayed when needed
    if params[:information_type][:information_field_type_data]
      information_type.data_translations= InformationTypeHelper.parse_data(params[:information_type][:information_field_type_data], information_type.information_field_type)
    end
		if	information_type.save
      flash[:success] = t('information_type.create.success')
      redirect_to information_types_path
    else
      flash[:error] = t('information_type.create.failure')
      redirect_to information_types_path
    end

  end

  # Gets all information_types
  # If there are none, return an empty array
  def list
    @information_types = InformationType.all
    if @information_types.nil?
      return Array.new
    end
  end

  def edit
    @information_type = InformationType.find_by id: params[:id]
  end

  def update
    information_type = InformationType.find_by(id: params[:id])
    params[:information_type][:information_field_type] = InformationFieldType.find_by_key params[:information_type][:information_field_type]
    params[:information_type][:scope] = Scope.find_by key: params[:information_type][:scope] if params[:information_type][:scope].size > 0  # dont check empty string
    information_type.update_attributes(params[:information_type])
    information_type.name_translations = params[:information_type][:name]
    information_type.data_translations = InformationTypeHelper.parse_data(params[:information_type][:information_field_type_data], information_type.information_field_type)
    if information_type.save
      flash[:sucess] = t('information_type.update.success')
      redirect_to information_types_path
    else
      flash[:error] = t('information_type.update.failure')
      redirect_to edit_information_type(information_type)
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