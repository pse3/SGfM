class InformationTypeController < ActionController::Base

  def reset_default_types
    InformationType.delete_all
    type_phone = InformationType.new
    type_phone.name = "Telefon"
    type_phone.key = :phone
    type_phone.save
  end


  def list_information_types
    @information_types = InformationType.each
  end

end