# encoding: utf-8

unless Rails.env == :production

  # Reset all objects and types
  Actor.delete_all
  Information.delete_all
  InformationType.delete_all
  ActorType.delete_all
  Information.delete_all
  Login.delete_all
  User.delete_all
  Admin.delete_all

  # Create some InformationTypes
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


  # Create some ActorTypes
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


  # Create some RelationshipTypes
  relation_works_with = RelationshipType.new
  relation_works_with.key = :works_with
  I18n.locale = :en
  relation_works_with.name = 'works with'
  I18n.locale = :de
  relation_works_with.name = 'arbeitet mit'
  I18n.locale = :it
  relation_works_with.name = '??'
  I18n.locale = :fr
  relation_works_with.name = '??'
  relation_works_with.save

  relation_other = RelationshipType.new
  relation_other.key = :other
  I18n.locale = :en
  relation_other.name = 'other'
  I18n.locale = :de
  relation_other.name = 'Andere'
  I18n.locale = :it
  relation_other.name = '??'
  I18n.locale = :fr
  relation_other.name = '??'
  relation_other.save

  # Create a User and Admin
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


  # Create some Actors

  # Dummy actor 'Insel'
  dummy_actor_insel = Actor.new
  dummy_actor_insel.actor_type = ActorType.find_by_key(:hospital)

  insel_name = Information.new
  insel_name.value = 'Insel'
  insel_name.information_type = InformationType.find_by_key(:company)
  insel_name.actor = dummy_actor_insel

  insel_phone = Information.new
  insel_phone.value = '033 iwas'
  insel_phone.information_type = InformationType.find_by_key(:phone)
  insel_phone.actor = dummy_actor_insel

  insel_email = Information.new
  insel_email.value = 'insel@bern.ch'
  insel_email.information_type = InformationType.find_by_key(:email)
  insel_email.actor = dummy_actor_insel

  insel_street = Information.new
  insel_street.value = 'Inselstrasse'
  insel_street.information_type = InformationType.find_by_key(:street)
  insel_street.actor = dummy_actor_insel

  insel_street_number = Information.new
  insel_street_number.value = '666'
  insel_street_number.information_type = InformationType.find_by_key(:street_number)
  insel_street_number.actor = dummy_actor_insel

  insel_zip_code = Information.new
  insel_zip_code.value = '4000'
  insel_zip_code.information_type = InformationType.find_by_key(:zip_code)
  insel_zip_code.actor = dummy_actor_insel

  insel_city = Information.new
  insel_city.value = 'Bern'
  insel_city.information_type = InformationType.find_by_key(:city)
  insel_city.actor = dummy_actor_insel

  insel_canton = Information.new
  insel_canton.value = 'BE'
  insel_canton.information_type = InformationType.find_by_key(:canton)
  insel_canton.actor = dummy_actor_insel

  user.actors.push(dummy_actor_insel)
  dummy_actor_insel.save
  user.save

  # Dummy doctor 'Karl Schürch'
  dummy_actor_karl = Actor.new
  dummy_actor_karl.actor_type = ActorType.find_by_key(:doctor)

  karl_fname = Information.new
  karl_fname.value = 'Karl'
  karl_fname.information_type = InformationType.find_by_key(:first_name)
  karl_fname.actor = dummy_actor_karl

  karl_lname = Information.new
  karl_lname.value = 'Schürch'
  karl_lname.information_type = InformationType.find_by_key(:last_name)
  karl_lname.actor = dummy_actor_karl

  karl_phone = Information.new
  karl_phone.value = '078 888 77 66'
  karl_phone.information_type = InformationType.find_by_key(:phone)
  karl_phone.actor = dummy_actor_karl

  karl_email = Information.new
  karl_email.value = 'karl@schürch.ch'
  karl_email.information_type = InformationType.find_by_key(:email)
  karl_email.actor = dummy_actor_karl

  karl_street = Information.new
  karl_street.value = 'Karlstrasse'
  karl_street.information_type = InformationType.find_by_key(:street)
  karl_street.actor = dummy_actor_karl

  karl_street_number = Information.new
  karl_street_number.value = '999'
  karl_street_number.information_type = InformationType.find_by_key(:street_number)
  karl_street_number.actor = dummy_actor_karl

  karl_zip_code = Information.new
  karl_zip_code.value = '-2000'
  karl_zip_code.information_type = InformationType.find_by_key(:zip_code)
  karl_zip_code.actor = dummy_actor_karl

  karl_city = Information.new
  karl_city.value = 'Bösingen'
  karl_city.information_type = InformationType.find_by_key(:city)
  karl_city.actor = dummy_actor_karl

  karl_canton = Information.new
  karl_canton.value = 'FR'
  karl_canton.information_type = InformationType.find_by_key(:canton)
  karl_canton.actor = dummy_actor_karl

  user.actors.push(dummy_actor_karl)
  dummy_actor_karl.save
  user.save


  # Create some Relations
  relationship_insel = Relationship.new
  relationship_insel.relationship_type = RelationshipType.find_by_key(:works_with)
  relationship_insel.comment = 'This is a comment. Made by god!'
  relationship_insel.actor = dummy_actor_insel
  relationship_insel.reference = dummy_actor_karl
  relationship_insel.save



end