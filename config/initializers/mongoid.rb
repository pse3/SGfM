# encoding: utf-8
unless Rails.env == :production

  #reset all objects and types
  Actor.delete_all
  Information.delete_all
  InformationType.delete_all
  ActorType.delete_all
  Information.delete_all
  Login.delete_all
  User.delete_all
  Admin.delete_all

  #create some information_types
  info_name = InformationType.new
  info_name.key = :name
  I18n.locale = :en
  info_name.name = "Name"
  I18n.locale = :de
  info_name.name = "Name"
  I18n.locale = :it
  info_name.name = "Nome"
  I18n.locale = :fr
  info_name.name = "Nom"
  info_name.save

  info_phone = InformationType.new
  info_phone.key = :phone
  I18n.locale = :en
  info_phone.name = "Phone"
  I18n.locale = :de
  info_phone.name = "Telefon"
  I18n.locale = :it
  info_phone.name = "Telefono"
  I18n.locale = :fr
  info_phone.name = "Téléphone"
  info_phone.save

  info_address = InformationType.new
  info_address.key = :address
  I18n.locale = :en
  info_address.name = "Address"
  I18n.locale = :de
  info_address.name = "Adresse"
  I18n.locale = :it
  info_address.name = "Indirizzo"
  I18n.locale = :fr
  info_address.name = "Adresse"
  info_address.save

  info_email = InformationType.new
  info_email.key = :email
  I18n.locale = :en
  info_email.name = "Email"
  I18n.locale = :de
  info_email.name = "E-Mail"
  I18n.locale = :it
  info_email.name = "Smalto"
  I18n.locale = :fr
  info_email.name = "Émail"
  info_email.save

  #create some actor_types
  actor_doctor = ActorType.new
  actor_doctor.key = :doctor
  actor_doctor.information_type.push(InformationType.find_by_key(:name))
  actor_doctor.information_type.push(InformationType.find_by_key(:phone))
  actor_doctor.information_type.push(InformationType.find_by_key(:address))
  actor_doctor.information_type.push(InformationType.find_by_key(:email))
  I18n.locale = :en
  actor_doctor.name = "Doctor"
  I18n.locale = :de
  actor_doctor.name = "Arzt"
  I18n.locale = :it
  actor_doctor.name = "Dottore"
  I18n.locale = :fr
  actor_doctor.name = "Médecin"
  actor_doctor.save

  actor_hospital = ActorType.new
  actor_hospital.key = :hospital
  actor_hospital.information_type.push(InformationType.find_by_key(:name))
  actor_hospital.information_type.push(InformationType.find_by_key(:phone))
  actor_hospital.information_type.push(InformationType.find_by_key(:address))
  I18n.locale = :en
  actor_hospital.name = "Hospital"
  I18n.locale = :de
  actor_hospital.name = "Spital"
  I18n.locale = :it
  actor_hospital.name = "Ospedale"
  I18n.locale = :fr
  actor_hospital.name = "Hôpital"
  actor_hospital.save


  #create a User and Login
  user = User.new
  login = Login.new(:email => 'email@domain.ch',
                    :password => 'test1234',
                    :password_confirmation => 'test1234')
  login.account = user
  user.save
  login.save
  admin = Admin.new
  login = Login.new(:email => 'admin@domain.ch',
                    :password => 'test1234',
                    :password_confirmation => 'test1234')
  login.account = admin
  admin.save
  login.save
end