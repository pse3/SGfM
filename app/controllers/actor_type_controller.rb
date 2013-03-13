class ActorTypeController < ActionController::Base

 def reset_default_types
    ActorType.delete_all
    type_doctor = ActorType.new
    type_doctor.name = "Arzt"
    type_doctor.key = :doctor
    type_doctor.save

    type_hospital = ActorType.new
    type_hospital.name = "Spital"
    type_hospital.key = :hospital
    type_hospital.save
 end

 def list_information_types

 end

end