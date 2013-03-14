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
  itype_email.name = "email"
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