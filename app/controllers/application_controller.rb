class ApplicationController < ActionController::Base

  protect_from_forgery


  def after_sign_in_path_for(login)
    '/logins/show'
  end

  def reset_all
    #reset all types
    Actor.delete_all
    InformationType.delete_all
    ActorType.delete_all

    #create some information_types
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

    #create some actor_types
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


  helper_method :current_actor, :current_actor=

  private
  def current_actor=(actor)
    @current_actor =actor
  end

  def current_actor
    @current_actor
  end

end
