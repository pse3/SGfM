class ActorTypeController < ActionController::Base


  # Resets all ActorTypes
  def reset_default_types
     ActorType.delete_all

     type_doctor = ActorType.new
     type_doctor.name = "Arzt"
     type_doctor.key = :doctor
     type_doctor.information_type.push(InformationType.find_by_key(:phone))
     type_doctor.information_type.push(InformationType.find_by_key(:address))
     type_doctor.information_type.push(InformationType.find_by_key(:email))
     type_doctor.save

     type_hospital = ActorType.new
     type_hospital.name = "Spital"
     type_hospital.key = :hospital
     type_hospital.information_type.push(InformationType.find_by_key(:phone))
     type_hospital.information_type.push(InformationType.find_by_key(:address))
     type_hospital.save
 end


end