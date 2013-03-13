class InformationTypeController < ActionController::Base

  # Resets all InformationTypes
  def reset_default_types
    InformationType.delete_all

    type_phone = InformationType.new
    type_phone.name = "Telefon"
    type_phone.key = :phone
    type_phone.save

    type_address = InformationType.new
    type_address.name = "Adresse"
    type_address.key = :address
    type_address.save

    type_email = InformationType.new
    type_email.name = "email"
    type_email.key = :email
    type_email.save
  end

end