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
	Scope.delete_all

  #create some scopes
  scope_private = WhitelistScope.new
  scope_private.key = :private
  I18n.locale = :en
  scope_private.name = 'private'
  I18n.locale = :de
  scope_private.name = 'privat'
  I18n.locale = :it
  scope_private.name = 'privato'
  I18n.locale = :fr
  scope_private.name = 'privé'
  scope_private.list = [:Self]
  scope_private.save

  scope_stats = WhitelistScope.new
  scope_stats.key = :statistics
  I18n.locale = :en
  scope_stats.name = 'private + statistics'
  I18n.locale = :de
  scope_stats.name = 'privat + statistik'
  I18n.locale = :it
  scope_stats.name = 'privato + statistiche'
  I18n.locale = :fr
  scope_stats.name = 'privé + statistique'
  scope_stats.list = [:Self, :Admin]
  scope_stats.save

  scope_public = BlacklistScope.new
  scope_public.key = :public
  I18n.locale = :en
  scope_public.name = 'public'
  I18n.locale = :de
  scope_public.name = 'öffentlich'
  I18n.locale = :it
  scope_public.name = 'pubblico'
  I18n.locale = :fr
  scope_public.name = 'public'
  scope_public.list = []
  scope_public.save

  #create some information_types
  info_company = InformationType.new
  info_company.key = :company
  I18n.locale = :en
  info_company.name = "Company"
  I18n.locale = :de
  info_company.name = "Firma"
  I18n.locale = :it
  info_company.name = "??"
  I18n.locale = :fr
  info_company.name = "??"
  info_company.save

  info_first_name = InformationType.new
  info_first_name.key = :first_name
  I18n.locale = :en
  info_first_name.name = "First name"
  I18n.locale = :de
  info_first_name.name = "Vorname"
  I18n.locale = :it
  info_first_name.name = "??"
  I18n.locale = :fr
  info_first_name.name = "??"
  info_first_name.scope = scope_public
  info_first_name.save

  info_last_name = InformationType.new
  info_last_name.key = :last_name
  I18n.locale = :en
  info_last_name.name = "Last name"
  I18n.locale = :de
  info_last_name.name = "Name"
  I18n.locale = :it
  info_last_name.name = "??"
  I18n.locale = :fr
  info_last_name.name = "??"
  info_last_name.scope = scope_public
  info_last_name.save

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

  info_mobile = InformationType.new
  info_mobile.key = :mobile
  I18n.locale = :en
  info_mobile.name = "Mobile"
  I18n.locale = :de
  info_mobile.name = "Mobil"
  I18n.locale = :it
  info_mobile.name = "??"
  I18n.locale = :fr
  info_mobile.name = "??"
  info_mobile.save

  info_fax = InformationType.new
  info_fax.key = :fax
  I18n.locale = :en
  info_fax.name = "Fax"
  I18n.locale = :de
  info_fax.name = "Fax"
  I18n.locale = :it
  info_fax.name = "??"
  I18n.locale = :fr
  info_fax.name = "??"
  info_fax.save

  info_street = InformationType.new
  info_street.key = :street
  I18n.locale = :en
  info_street.name = "Street"
  I18n.locale = :de
  info_street.name = "Strasse"
  I18n.locale = :it
  info_street.name = "??"
  I18n.locale = :fr
  info_street.name = "??"
  info_street.save

  info_street_number = InformationType.new
  info_street_number.key = :street_number
  I18n.locale = :en
  info_street_number.name = "Street number"
  I18n.locale = :de
  info_street_number.name = "Strassennummer"
  I18n.locale = :it
  info_street_number.name = "??"
  I18n.locale = :fr
  info_street_number.name = "??"
  info_street_number.save

  info_zip_code = InformationType.new
  info_zip_code.key = :zip_code
  I18n.locale = :en
  info_zip_code.name = "ZIP"
  I18n.locale = :de
  info_zip_code.name = "PLZ"
  I18n.locale = :it
  info_zip_code.name = "??"
  I18n.locale = :fr
  info_zip_code.name = "??"
  info_zip_code.save

  info_city = InformationType.new
  info_city.key = :city
  I18n.locale = :en
  info_city.name = "City"
  I18n.locale = :de
  info_city.name = "Stadt"
  I18n.locale = :it
  info_city.name = "??"
  I18n.locale = :fr
  info_city.name = "??"
  info_city.save

  info_canton = InformationType.new
  info_canton.key = :canton
  I18n.locale = :en
  info_canton.name = "Canton"
  I18n.locale = :de
  info_canton.name = "Kanton"
  I18n.locale = :it
  info_canton.name = "??"
  I18n.locale = :fr
  info_canton.name = "??"
  info_canton.save

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
  actor_doctor.information_type.push(info_first_name)
  actor_doctor.information_type.push(info_last_name)
  actor_doctor.information_type.push(info_phone)
  actor_doctor.information_type.push(info_email)
  actor_doctor.information_type.push(info_street)
  actor_doctor.information_type.push(info_street_number)
  actor_doctor.information_type.push(info_zip_code)
  actor_doctor.information_type.push(info_city)
  actor_doctor.information_type.push(info_canton)
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
  actor_hospital.information_type.push(info_company)
  actor_hospital.information_type.push(info_phone)
  actor_hospital.information_type.push(info_email)
  actor_hospital.information_type.push(info_street)
  actor_hospital.information_type.push(info_street_number)
  actor_hospital.information_type.push(info_zip_code)
  actor_hospital.information_type.push(info_city)
  actor_hospital.information_type.push(info_canton)
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