require 'spec_helper'

#Capybara.match = :first

describe "actor spec" do

  before do
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

    scope_stats = WhitelistScope.new
    scope_stats.key = :statistics
    scope_stats.name_translations = { :en => 'private + statistics', :de => 'privat + statistik', :it => 'privato + statistiche', :fr => 'prive + statistique' }
    scope_stats.list = [:Self, :Admin]
    scope_stats.save

    scope_public = BlacklistScope.new
    scope_public.key = :public
    scope_public.name_translations = { :en => 'public', :de => 'oeffentlich', :it => 'pubblico', :frc=> 'public' }
    scope_public.list = []
    scope_public.save

    scope_private = WhitelistScope.new
    scope_private.key = :private
    scope_private.name_translations = { :en => 'private', :de => 'privat', :it => 'privato', :fr => 'prive' }
    scope_private.list = [:Self]
    scope_private.save

    #create the information field types
    information_field_text = InformationFieldText.new
    information_field_text.key = :text
    information_field_text.name_translations = { :en => 'Text field', :de => 'Textfeld', :it => '???', :fr => '???' }
    information_field_text.save

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
    info_medical_specialisations.scope = scope_public
    info_medical_specialisations.save

    info_company = InformationType.new
    info_company.key = :company
    info_company.information_field_type = information_field_text
    info_company.name_translations = { :en => 'Company', :de =>'Firma', :it => '??', :fr => '??' }
    info_company.scope = scope_public
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
    info_phone.name_translations = { :en => 'Phone', :de =>'Telefon', :it => 'Telefono', :fr => 'Telephone' }
    info_phone.save

    info_canton = InformationType.new
    info_canton.key = :canton
    info_canton.information_field_type = information_field_text
    info_canton.name_translations = { :en => 'Canton', :de =>'Kanton', :it => '??', :fr => '??' }
    info_canton.scope = scope_public
    info_canton.save

    # Create some RelationshipTypes
    relation_works_with = RelationshipType.new
    relation_works_with.key = :works_with
    relation_works_with.name_translations = { :en => 'works with', :de =>'arbeitet mit', :it => '??', :fr => '??' }
    relation_works_with.question_translations = {
        :en => 'With whom do you work?',
        :de => 'Mit wem arbeitet Ihr?',
        :it => '??',
        :fr => '??'
    }
    relation_works_with.save

    relation_assigns = RelationshipType.new
    relation_assigns.key = :assign_to
    relation_assigns.name_translations = { :en => 'assign to', :de =>'Ueberweisung an', :it => '??', :fr => '??' }
    relation_assigns.question_translations = {
        :en => 'To whom do you assign patients?',
        :de => 'An wen ueberweist Ihr Patienten?',
        :it => '??',
        :fr => '??'
    }
    relation_assigns.save

    relation_other = RelationshipType.new
    relation_other.key = :other
    relation_other.name_translations = { :en => 'other', :de =>'Andere', :it => '??', :fr => '??' }
    relation_other.question_translations = {
        :en => 'Do you have other relations you want to mention?',
        :de => 'Haben Sie andere Beziehungen, die Sie angeben moechten?',
        :it => '??',
        :fr => '??'
    }
    relation_other.save


    # Create some ActorTypes
    actor_doctor = ActorType.new
    actor_doctor.key = :doctor
    InformationTypeDecorator.create(info_medical_specialisations, actor_doctor, true, true)
    InformationTypeDecorator.create(info_first_name, actor_doctor,  true, true)
    InformationTypeDecorator.create(info_last_name, actor_doctor, true, true)
    InformationTypeDecorator.create(info_phone, actor_doctor, false, true)
    InformationTypeDecorator.create(info_canton, actor_doctor, false, true)
    actor_doctor.name_translations = { :en => 'Doctor', :de =>'Arzt', :it => 'Dottore', :fr => 'Medecin' }
    actor_doctor.to_string_pattern = '|:last_name| |:first_name|'
    actor_doctor.save


    actor_hospital = ActorType.new
    actor_hospital.key = :hospital
    InformationTypeDecorator.create(info_company, actor_hospital, true, true)
    InformationTypeDecorator.create(info_phone, actor_hospital, false, true)
    InformationTypeDecorator.create(info_canton, actor_hospital, true, true)
    actor_hospital.name_translations = { :en => 'Hospital', :de =>'Spital', :it => 'Ospedale', :fr => 'Hopital' }
    actor_hospital.to_string_pattern = '|:company|//|:canton|'
    actor_hospital.save


    admin = Admin.new
    login = Login.new(:email => 'admin@domain.ch',
                      :password => 'test1234',
                      :password_confirmation => 'test1234')
    login.account = admin
    admin.save
    login.save

    visit '/'
  end

  it 'creates an information type decorator and adds it to actor type if in params of create'
  it 'updates an actor type'
  it 'creates an information type decorator and adds it to actor type if in params of updates'

   it "creates an actor type", :js => true do
     click_on 'Sign in'
     fill_in "login_email", :with => 'admin@domain.ch'
     fill_in "login_password", :with => 'test1234'
     click_button 'Sign in'
     sleep(0.5)
     click_on "Create new actor"

     #TODO

   end

end
