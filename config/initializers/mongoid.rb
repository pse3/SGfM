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
  Scope.delete_all

  #create some scopes
  scope_private = WhitelistScope.new
  scope_private.key = :private
  scope_private.name_translations = { :en => 'private', :de => 'privat', :it => 'privato', :fr => 'privé' }
  scope_private.list = [:Self]
  scope_private.save

  scope_stats = WhitelistScope.new
  scope_stats.key = :statistics
  scope_stats.name_translations = { :en => 'private + statistics', :de => 'privat + statistik', :it => 'privato + statistiche', :fr => 'privé + statistique' }
  scope_stats.list = [:Self, :Admin]
  scope_stats.save

  scope_public = BlacklistScope.new
  scope_public.key = :public
  scope_public.name_translations = { :en => 'public', :de => 'öffentlich', :it => 'pubblico', :frc=> 'public' }
  scope_public.list = []
  scope_public.save

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
  info_medical_specialisations.data_translations = { :de => ['Gynokologe', 'Kinderarzt', 'Urologoe' ],
                                                     :en => ['gynecologist', 'pediatrist', 'urologist'],
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
  info_gender.name_translations = { :en => 'Gender', :de =>'Geschlecht', :it => '??', :fr => '??' }
  info_gender.save

  info_company = InformationType.new
  info_company.key = :company
  info_company.information_field_type = information_field_text
  info_company.name_translations = { :en => 'Company', :de =>'Firma', :it => '??', :fr => '??' }
  info_company.save

  info_first_name = InformationType.new
  info_first_name.key = :first_name
  info_first_name.information_field_type = information_field_text
  info_first_name.name_translations = { :en => 'First name', :de =>'Vorname', :it => '??', :fr => '??' }
  info_first_name.scope = scope_public
  info_first_name.save

  info_last_name = InformationType.new
  info_last_name.key = :last_name
  info_last_name.information_field_type = information_field_text
  info_last_name.name_translations = { :en => 'Last name', :de =>'Name', :it => '??', :fr => '??' }
  info_last_name.scope = scope_public
  info_last_name.save

  info_phone = InformationType.new
  info_phone.key = :phone
  info_phone.information_field_type = information_field_text
  info_phone.name_translations = { :en => 'Phone', :de =>'Telefon', :it => 'Telefono', :fr => 'Téléphone' }
  info_phone.save

  info_mobile = InformationType.new
  info_mobile.key = :mobile
  info_mobile.information_field_type = information_field_text
  info_mobile.name_translations = { :en => 'Mobile', :de =>'Mobil', :it => '??', :fr => '??' }
  info_mobile.save

  info_fax = InformationType.new
  info_fax.key = :fax
  info_fax.information_field_type = information_field_text
  info_fax.name_translations = { :en => 'Fax', :de =>'Fax', :it => '??', :fr => '??' }
  info_fax.save

  info_street = InformationType.new
  info_street.key = :street
  info_street.information_field_type = information_field_text
  info_street.name_translations = { :en => 'Street', :de =>'Strasse', :it => '??', :fr => '??' }
  info_street.save

  info_street_number = InformationType.new
  info_street_number.key = :street_number
  info_street_number.information_field_type = information_field_text
  info_street_number.name_translations = { :en => 'Street number', :de =>'Strassennummer', :it => '??', :fr => '??' }
  info_street_number.save

  info_zip_code = InformationType.new
  info_zip_code.key = :zip_code
  info_zip_code.information_field_type = information_field_text
  info_zip_code.name_translations = { :en => 'ZIP', :de =>'PLZ', :it => '??', :fr => '??' }
  info_zip_code.save

  info_city = InformationType.new
  info_city.key = :city
  info_city.information_field_type = information_field_text
  info_city.name_translations = { :en => 'City', :de =>'Stadt', :it => '??', :fr => '??' }
  info_city.save

  info_canton = InformationType.new
  info_canton.key = :canton
  info_canton.information_field_type = information_field_text
  info_canton.name_translations = { :en => 'Canton', :de =>'Kanton', :it => '??', :fr => '??' }
  info_canton.save

  info_email = InformationType.new
  info_email.key = :email
  info_email.information_field_type = information_field_text
  info_email.name_translations = { :en => 'Email', :de =>'E-Mail', :it => 'Smalto', :fr => 'Émail' }
  info_email.save


  # Create some ActorTypes
  actor_doctor = ActorType.new
  actor_doctor.key = :doctor
  InformationTypeDecorator.create(info_medical_specialisations, actor_doctor, true, true)
  InformationTypeDecorator.create(info_first_name, actor_doctor,  true, true)
  InformationTypeDecorator.create(info_last_name, actor_doctor, true, true)
  InformationTypeDecorator.create(info_gender, actor_doctor, false, true)
  InformationTypeDecorator.create(info_phone, actor_doctor, false, true)
  InformationTypeDecorator.create(info_email, actor_doctor, false, true)
  InformationTypeDecorator.create(info_street, actor_doctor, true, true)
  InformationTypeDecorator.create(info_street_number, actor_doctor, true, true)
  InformationTypeDecorator.create(info_zip_code, actor_doctor, true, true)
  InformationTypeDecorator.create(info_city, actor_doctor, false, true)
  InformationTypeDecorator.create(info_canton, actor_doctor, false, true)
  actor_doctor.name_translations = { :en => 'Doctor', :de =>'Arzt', :it => 'Dottore', :fr => 'Médecin' }
  actor_doctor.to_string_pattern = '|:last_name| |:first_name|'
  actor_doctor.save


  actor_hospital = ActorType.new
  actor_hospital.key = :hospital
  InformationTypeDecorator.create(info_company, actor_hospital, true, true)
  InformationTypeDecorator.create(info_phone, actor_hospital, false, true)
  InformationTypeDecorator.create(info_email, actor_hospital, false, true)
  InformationTypeDecorator.create(info_street, actor_hospital, true, true)
  InformationTypeDecorator.create(info_street_number, actor_hospital, true, true)
  InformationTypeDecorator.create(info_zip_code, actor_hospital, true, true)
  InformationTypeDecorator.create(info_city, actor_hospital, true, true)
  InformationTypeDecorator.create(info_canton, actor_hospital, true, true)
  actor_hospital.name_translations = { :en => 'Hospital', :de =>'Spital', :it => 'Ospedale', :fr => 'Hôpital' }
  actor_hospital.to_string_pattern = '|:company|//|:canton|'
  actor_hospital.save

  # Create some RelationshipTypes
  relation_works_with = RelationshipType.new
  relation_works_with.key = :works_with
  relation_works_with.name_translations = { :en => 'works with', :de =>'arbeitet mit', :it => '??', :fr => '??' }
  relation_works_with.save

  relation_other = RelationshipType.new
  relation_other.key = :assign_to
  relation_other.name_translations = { :en => 'assign to', :de =>'Überweisung an', :it => '??', :fr => '??' }
  relation_other.save

  relation_other = RelationshipType.new
  relation_other.key = :other
  relation_other.name_translations = { :en => 'other', :de =>'Andere', :it => '??', :fr => '??' }
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
  dummy_actor_type = dummy_actor_insel.actor_type

  insel_name = Information.new
  insel_name.scope = scope_public
  insel_name.information_type_decorator = dummy_actor_type.decorator_by_key(:company)
  insel_name.value = 'Insel'
  insel_name.actor = dummy_actor_insel

  insel_phone = Information.new
  insel_phone.scope = scope_public
  insel_phone.information_type_decorator = dummy_actor_type.decorator_by_key(:phone)
  insel_phone.value = '033 777 88 11'
  insel_phone.actor = dummy_actor_insel

  insel_email = Information.new
  insel_email.scope = scope_public
  insel_email.information_type_decorator = dummy_actor_type.decorator_by_key(:email)
  insel_email.value = 'insel@bern.ch'
  insel_email.actor = dummy_actor_insel

  insel_street = Information.new
  insel_street.scope = scope_public
  insel_street.information_type_decorator = dummy_actor_type.decorator_by_key(:street)
  insel_street.value = 'Inselstrasse'
  insel_street.actor = dummy_actor_insel

  insel_street_number = Information.new
  insel_street_number.scope = scope_public
  insel_street_number.information_type_decorator = dummy_actor_type.decorator_by_key(:street_number)
  insel_street_number.value = '666'
  insel_street_number.actor = dummy_actor_insel

  insel_zip_code = Information.new
  insel_zip_code.scope = scope_public
  insel_zip_code.information_type_decorator = dummy_actor_type.decorator_by_key(:zip_code)
  insel_zip_code.value = '4000'
  insel_zip_code.actor = dummy_actor_insel

  insel_city = Information.new
  insel_city.scope = scope_public
  insel_city.information_type_decorator = dummy_actor_type.decorator_by_key(:city)
  insel_city.value = 'Bern'
  insel_city.actor = dummy_actor_insel

  insel_canton = Information.new
  insel_canton.scope = scope_public
  insel_canton.information_type_decorator = dummy_actor_type.decorator_by_key(:canton)
  insel_canton.value = 'BE'
  insel_canton.actor = dummy_actor_insel

  user.actors.push(dummy_actor_insel)
  dummy_actor_insel.save
  user.save

  # Dummy doctor 'Karl Schürch'
  dummy_actor_karl = Actor.new
  dummy_actor_karl.actor_type = ActorType.find_by_key(:doctor)
  dummy_actor_type = dummy_actor_karl.actor_type

  karl_medical_specialisations = Information.new
  karl_medical_specialisations.information_type_decorator = dummy_actor_type.decorator_by_key(:medical_specialisations)
  karl_medical_specialisations.scope = scope_public
  karl_medical_specialisations.value = ['Childdoctor']
  karl_medical_specialisations.actor = dummy_actor_karl

  karl_gender = Information.new
  karl_gender.information_type_decorator = dummy_actor_type.decorator_by_key(:gender)
  karl_gender.scope = scope_public
  karl_gender.value = 'Male'
  karl_gender.actor = dummy_actor_karl

  karl_fname = Information.new
  karl_fname.information_type_decorator = dummy_actor_type.decorator_by_key(:first_name)
  karl_fname.scope = scope_public
  karl_fname.value = 'Karl'
  karl_fname.actor = dummy_actor_karl

  karl_lname = Information.new
  karl_lname.information_type_decorator = dummy_actor_type.decorator_by_key(:last_name)
  karl_lname.scope = scope_public
  karl_lname.value = 'Schürch'
  karl_lname.actor = dummy_actor_karl

  karl_phone = Information.new
  karl_phone.information_type_decorator = dummy_actor_type.decorator_by_key(:phone)
  karl_phone.scope = scope_private
  karl_phone.value = '078 888 77 66'
  karl_phone.actor = dummy_actor_karl

  karl_email = Information.new
  karl_email.information_type_decorator = dummy_actor_type.decorator_by_key(:email)
  karl_email.scope = scope_public
  karl_email.value = 'karl@schürch.ch'
  karl_email.actor = dummy_actor_karl

  karl_street = Information.new
  karl_street.information_type_decorator = dummy_actor_type.decorator_by_key(:street)
  karl_street.scope = scope_public
  karl_street.value = 'Karlstrasse'
  karl_street.actor = dummy_actor_karl

  karl_street_number = Information.new
  karl_street_number.information_type_decorator = dummy_actor_type.decorator_by_key(:street_number)
  karl_street_number.scope = scope_private
  karl_street_number.value = '999'
  karl_street_number.actor = dummy_actor_karl

  karl_zip_code = Information.new
  karl_zip_code.information_type_decorator = dummy_actor_type.decorator_by_key(:zip_code)
  karl_zip_code.scope = scope_private
  karl_zip_code.value = '3178'
  karl_zip_code.actor = dummy_actor_karl

  karl_city = Information.new
  karl_city.information_type_decorator = dummy_actor_type.decorator_by_key(:city)
  karl_city.scope = scope_private
  karl_city.value = 'Bösingen'
  karl_city.actor = dummy_actor_karl

  karl_canton = Information.new
  karl_canton.information_type_decorator = dummy_actor_type.decorator_by_key(:canton)
  karl_canton.scope = scope_private
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