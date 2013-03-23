class InformationTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!


  # Gets all information_types
  # If there are none, return an empty array
  def list
    @information_field_types = InformationFieldType.all
    if @information_Field_types.nil?
      return Array.new
    end
  end

  # Find information_type with given id
  def show
    @information_field_type = InformationFieldType.find(params[:id])
  end

end