require 'spec_helper'

#Capybara.match = :first

describe "Actor type" do

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

  it "is created", :js => true do
     click_on 'Sign in'
     fill_in "login_email", :with => 'admin@domain.ch'
     fill_in "login_password", :with => 'test1234'
     click_button 'Sign in'
     sleep(0.5)
     click_on "Create new actor type"
     fill_in 'actor_type_name_translations[en]', :with => 'TestActorTypeEnglish'
     fill_in 'actor_type_name_translations[de]', :with => 'TestActorTypeGerman'
     fill_in 'actor_type_name_translations[it]', :with => 'TestActorTypeItalian'
     fill_in 'actor_type_name_translations[fr]', :with => 'TestActorTypeFrench'
     click_on 'Add Information Type'
     select('Medical specialisations', :from => 'information_type_decorator_information_type')
     select('Yes', :from => 'information_type_decorator_required')
     select('Yes', :from => 'information_type_decorator_searchable')
     click_on 'Add Information Type'
     sleep(0.5)
     page.all("#information_type_decorator_information_type")[1].select("First name")
     page.all("#information_type_decorator_required")[1].select("Yes")
     page.all("#information_type_decorator_searchable")[1].select("Yes")
     click_on 'Add Information Type'
     sleep(0.5)
     page.all("#information_type_decorator_information_type")[2].select("Company")
     page.all("#information_type_decorator_required")[2].select("No")
     page.all("#information_type_decorator_searchable")[2].select("Yes")

     fill_in 'actor_type_to_string_pattern', :with => 'TestStringRepresentation'

     click_on 'Create'

     page.should have_content('TestActorTypeEnglish')
     page.should have_content('uccessfully')
     click_on 'Sign out'
     click_link "Sign up"
     within('#new_login') do
       fill_in 'login_email', :with => 'test_1@test.de'
       fill_in 'login_password', :with => '1234test'
       fill_in 'login_password_confirmation', :with => '1234test'
       click_button 'Sign up'
     end
     sleep(0.5)
     within('#actor-type') do
       find('#actor-type-select').should have_content('TestActorTypeEnglish')
     end
    click_on 'Sign out'
  end

  it 'is updated', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    page.first(".icon-edit").click
    fill_in 'actor_type_name[en]', :with => 'NewNameOfTestActorType'
    click_on 'update'
    page.should have_content("uccessfully")
    page.should have_content("NewNameOfTestActorType")
    page.should_not have_content("Doctor")
    click_on 'Sign out'

  end

end
