class ApplicationController < ActionController::Base

  protect_from_forgery


  def after_sign_in_path_for(login)
    '/logins/show'
  end

  def reset_all
    #reset all objects and types
    Actor.delete_all
    Information.delete_all
    InformationType.delete_all
    ActorType.delete_all

    #create some information_type
    itype_name = InformationType.new
    itype_name.name = "Name"
    itype_name.key = :name
    itype_name.save

    itype_phone = InformationType.new
    itype_phone.name = "Telefon"
    itype_phone.key = :phone
    itype_phone.save

    itype_address = InformationType.new
    itype_address.name = "Adresse"
    itype_address.key = :address
    itype_address.save

    itype_email = InformationType.new
    itype_email.name = "Email"
    itype_email.key = :email
    itype_email.save

    #create some actor_types
    atype_doctor = ActorType.new
    atype_doctor.name = "Arzt"
    atype_doctor.key = :doctor
    atype_doctor.information_type.push(InformationType.find_by_key(:name))
    atype_doctor.information_type.push(InformationType.find_by_key(:phone))
    atype_doctor.information_type.push(InformationType.find_by_key(:address))
    atype_doctor.information_type.push(InformationType.find_by_key(:email))
    atype_doctor.save

    atype_hospital = ActorType.new
    atype_hospital.name = "Spital"
    atype_hospital.key = :hospital
    atype_hospital.information_type.push(InformationType.find_by_key(:name))
    atype_hospital.information_type.push(InformationType.find_by_key(:phone))
    atype_hospital.information_type.push(InformationType.find_by_key(:address))
    atype_hospital.save

    redirect_to '/'
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
