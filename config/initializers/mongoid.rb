# encoding: utf-8
unless Rails.env == :production

  # Reset all objects and types
  Actor.delete_all
  Information.delete_all
  InformationType.delete_all
  InformationTypeDecorator.delete_all
  InformationFieldType.delete_all
  ActorType.delete_all
  Information.delete_all
  InformationType.delete_all
  Relationship.delete_all
  RelationshipType.delete_all
  Login.delete_all
  User.delete_all
  Admin.delete_all

  #create the information field types
  information_field_text = InformationFieldText.new
  information_field_text.key = :text
  information_field_text.name_translations = { :en => 'Text field', :de => 'Textfeld', :it => '???', :fr => '???' }
  information_field_text.save

  information_field_email = InformationFieldEmail.new
  information_field_email.key = :email
  information_field_email.name_translations = { :en => 'Email field', :de => 'Emailfeld', :it => '???', :fr => '???' }
  information_field_email.save

  information_field_date = InformationFieldDate.new
  information_field_date.key = :date
  information_field_date.name_translations = { :en => 'Date field', :de => 'Datumsfeld', :it => '???', :fr => '???' }
  information_field_date.save

  information_field_single_select = InformationFieldSingleSelect.new
  information_field_single_select.key = :single_select
  information_field_single_select.name_translations = { :en => 'single selection', :de => 'Einzelauswahl', :it => '???', :fr => '???' }
  information_field_single_select.save

  information_field_multiple_select = InformationFieldMultipleSelect.new
  information_field_multiple_select.key = :multiple_select
  information_field_multiple_select.name_translations = { :en => 'multiple selection', :de => 'Mehrauswahl', :it => '???', :fr => '???' }
  information_field_multiple_select.save


  #create some information_types
  info_medical_specialisations = InformationType.new
  info_medical_specialisations.key = :medical_specialisations
  info_medical_specialisations.information_field_type = information_field_multiple_select
  info_medical_specialisations.data_translations = { :de => ['Frauenarzt', 'Kinderarzt', 'Urologoe' ],
                                                     :en => ['Womendoctor', 'Childdoctor', 'Penisdoctor'],
                                                     :fr => ['??', '??', '??'],
                                                     :it => ['??', '??', '??'] }
  info_medical_specialisations.name_translations = {:en => 'Medical specialisations', :de => 'Fachgebiete', :it => '??', :fr => '??' }
  info_medical_specialisations.save

  info_gender = InformationType.new
  info_gender.key = :gender
  info_gender.information_field_type = information_field_single_select
  info_gender.data_translations = { :en => ['Male', 'Female'],
                                    :de => ['Männlich', 'Weiblich'],
                                    :fr => ['??', '??'],
                                    :it => ['??', '??'] }
  info_gender.name_translations = {:en => "Gender", :de =>"Geschlecht", :it => "??", :fr => "??" }
  info_gender.save

  info_company = InformationType.new
  info_company.key = :company
  info_company.information_field_type = information_field_text
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
  info_first_name.information_field_type = information_field_text
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
  info_last_name.information_field_type = information_field_text
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
  info_phone.information_field_type = information_field_text
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
  info_mobile.information_field_type = information_field_text
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
  info_fax.information_field_type = information_field_text
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
  info_street.information_field_type = information_field_text
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
  info_street_number.information_field_type = information_field_text
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
  info_zip_code.information_field_type = information_field_text
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
  info_city.information_field_type = information_field_text
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
  info_canton.information_field_type = information_field_text
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
  info_email.information_field_type = information_field_text
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
  InformationTypeDecorator.create(info_medical_specialisations, actor_doctor, 1, true, true)
  InformationTypeDecorator.create(info_first_name, actor_doctor, 2, true, true)
  InformationTypeDecorator.create(info_last_name, actor_doctor, 3, true, true)
  InformationTypeDecorator.create(info_gender, actor_doctor, 4, true, true)
  InformationTypeDecorator.create(info_phone, actor_doctor, 5, true, true)
  InformationTypeDecorator.create(info_email, actor_doctor, 6, true, true)
  InformationTypeDecorator.create(info_street, actor_doctor, 7, true, true)
  InformationTypeDecorator.create(info_street_number, actor_doctor, 8, true, true)
  InformationTypeDecorator.create(info_zip_code, actor_doctor, 9, true, true)
  InformationTypeDecorator.create(info_city, actor_doctor, 10, true, true)
  InformationTypeDecorator.create(info_canton, actor_doctor, 11, true, true)
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
  InformationTypeDecorator.create(info_company, actor_hospital, 1, true, true)
  InformationTypeDecorator.create(info_phone, actor_hospital, 2, true, true)
  InformationTypeDecorator.create(info_email, actor_hospital, 3, true, true)
  InformationTypeDecorator.create(info_street, actor_hospital, 4, true, true)
  InformationTypeDecorator.create(info_street_number, actor_hospital, 5, true, true)
  InformationTypeDecorator.create(info_zip_code, actor_hospital, 6, true, true)
  InformationTypeDecorator.create(info_city, actor_hospital, 7, true, true)
  InformationTypeDecorator.create(info_canton, actor_hospital, 8, true, true)

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
  insel_name.information_type = InformationType.find_by_key(:company)
  insel_name.value = 'Insel'
  insel_name.actor = dummy_actor_insel

  insel_phone = Information.new
  insel_phone.information_type = InformationType.find_by_key(:phone)
  insel_phone.value = '033 777 88 11'
  insel_phone.actor = dummy_actor_insel

  insel_email = Information.new
  insel_email.information_type = InformationType.find_by_key(:email)
  insel_email.value = 'insel@bern.ch'
  insel_email.actor = dummy_actor_insel

  insel_street = Information.new
  insel_street.information_type = InformationType.find_by_key(:street)
  insel_street.value = 'Inselstrasse'
  insel_street.actor = dummy_actor_insel

  insel_street_number = Information.new
  insel_street_number.information_type = InformationType.find_by_key(:street_number)
  insel_street_number.value = '666'
  insel_street_number.actor = dummy_actor_insel

  insel_zip_code = Information.new
  insel_zip_code.information_type = InformationType.find_by_key(:zip_code)
  insel_zip_code.value = '4000'
  insel_zip_code.actor = dummy_actor_insel

  insel_city = Information.new
  insel_city.information_type = InformationType.find_by_key(:city)
  insel_city.value = 'Bern'
  insel_city.actor = dummy_actor_insel

  insel_canton = Information.new
  insel_canton.information_type = InformationType.find_by_key(:canton)
  insel_canton.value = 'BE'
  insel_canton.actor = dummy_actor_insel

  user.actors.push(dummy_actor_insel)
  dummy_actor_insel.save
  user.save

  # Dummy doctor 'Karl Schürch'
  dummy_actor_karl = Actor.new
  dummy_actor_karl.actor_type = ActorType.find_by_key(:doctor)

  karl_medical_specialisations = Information.new
  karl_medical_specialisations.information_type = InformationType.find_by_key(:medical_specialisations)
  karl_medical_specialisations.value = ['Childdoctor']
  karl_medical_specialisations.actor = dummy_actor_karl

  karl_gender = Information.new
  karl_gender.information_type = InformationType.find_by_key(:gender)
  karl_gender.value = 'Male'
  karl_gender.actor = dummy_actor_karl

  karl_fname = Information.new
  karl_fname.information_type = InformationType.find_by_key(:first_name)
  karl_fname.value = 'Karl'
  karl_fname.actor = dummy_actor_karl

  karl_lname = Information.new
  karl_lname.information_type = InformationType.find_by_key(:last_name)
  karl_lname.value = 'Schürch'
  karl_lname.actor = dummy_actor_karl

  karl_phone = Information.new
  karl_phone.information_type = InformationType.find_by_key(:phone)
  karl_phone.value = '078 888 77 66'
  karl_phone.actor = dummy_actor_karl

  karl_email = Information.new
  karl_email.information_type = InformationType.find_by_key(:email)
  karl_email.value = 'karl@schürch.ch'
  karl_email.actor = dummy_actor_karl

  karl_street = Information.new
  karl_street.information_type = InformationType.find_by_key(:street)
  karl_street.value = 'Karlstrasse'
  karl_street.actor = dummy_actor_karl

  karl_street_number = Information.new
  karl_street_number.information_type = InformationType.find_by_key(:street_number)
  karl_street_number.value = '999'
  karl_street_number.actor = dummy_actor_karl

  karl_zip_code = Information.new
  karl_zip_code.information_type = InformationType.find_by_key(:zip_code)
  karl_zip_code.value = '3178'
  karl_zip_code.actor = dummy_actor_karl

  karl_city = Information.new
  karl_city.information_type = InformationType.find_by_key(:city)
  karl_city.value = 'Bösingen'
  karl_city.actor = dummy_actor_karl

  karl_canton = Information.new
  karl_canton.information_type = InformationType.find_by_key(:canton)
  karl_canton.value = 'FR'
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