require 'spec_helper'

#Capybara.match = :first

describe "actor spec" do

  before do
    # Reset all objects and types
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


    user = User.new
    login = Login.new(:email => 'email@domain.ch',
                      :password => 'test1234',
                      :password_confirmation => 'test1234')
    login.account = user
    user.save

    user2 = User.new
    login = Login.new(:email => 'user@domain.ch',
                      :password => 'test1234',
                      :password_confirmation => 'test1234')
    login.account = user2
    user2.save

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
    insel_name.information_type_decorator = dummy_actor_type.decorator_by_key(:company)
    insel_name.value = 'Insel'
    insel_name.actor = dummy_actor_insel

    insel_phone = Information.new
    insel_phone.scope = scope_public
    insel_phone.information_type_decorator = dummy_actor_type.decorator_by_key(:phone)
    insel_phone.value = '033 777 88 11'
    insel_phone.actor = dummy_actor_insel

    insel_canton = Information.new
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
    karl_medical_specialisations.value = ['Childdoctor']
    karl_medical_specialisations.actor = dummy_actor_karl

    karl_fname = Information.new
    karl_fname.information_type_decorator = dummy_actor_type.decorator_by_key(:first_name)
    karl_fname.value = 'Karl'
    karl_fname.actor = dummy_actor_karl

    karl_lname = Information.new
    karl_lname.information_type_decorator = dummy_actor_type.decorator_by_key(:last_name)
    karl_lname.value = 'Schuerch'
    karl_lname.actor = dummy_actor_karl

    karl_phone = Information.new
    karl_phone.information_type_decorator = dummy_actor_type.decorator_by_key(:phone)
    karl_phone.scope = scope_private
    karl_phone.value = '078 888 77 66'
    karl_phone.actor = dummy_actor_karl

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

    visit '/'
  end

  #context "with full information" do
  #  it "creates a new actor",:js => true do
  #
  #    click_link("Sign up")
  #    within('#new_login') do
  #      fill_in 'login_email', :with => 'test_1@test.de'
  #      fill_in 'login_password', :with => '1234test'
  #      fill_in 'login_password_confirmation', :with => '1234test'
  #      click_button 'Sign up'
  #    end
  #    sleep(1)
  #    within('#actor-type') do
  #     click_link 'Next'
  #    end
  #    select('gynecologist', :from => 'actor_information_medical_specialisations')
  #    fill_in "actor_information_name_test", :with => 'TestFirstname'
  #    fill_in "actor_information_phone_test", :with => '033 333 333 333'
  #    click_link 'Next'
  #    click_button 'Create'
  #    page.should have_content("successfully")
  #    click_link 'Sign out'
  #  end
  #end
  #context "with only the required  information" do
  #  it "creates a new actor",:js => true do
  #
  #    click_link("Sign up")
  #    within('#new_login') do
  #      fill_in 'login_email', :with => 'test_2@test.de'
  #      fill_in 'login_password', :with => '1234test'
  #      fill_in 'login_password_confirmation', :with => '1234test'
  #      click_button 'Sign up'
  #    end
  #    sleep(1)
  #    within('#actor-type') do
  #      click_link 'Next'
  #    end
  #    select('gynecologist', :from => 'actor_information_medical_specialisations')
  #    fill_in "actor_information_phone_test", :with => '033 333 333 333'
  #    click_link 'Next'
  #    click_button 'Create'
  #    page.should have_content("successfully")
  #    click_link 'Sign out'
  #  end
  #end
  #context "with incomplete information" do
  #  it "creates a new actor",:js => true do
  #
  #    click_link("Sign up")
  #    within('#new_login') do
  #      fill_in 'login_email', :with => 'test_2@test.de'
  #      fill_in 'login_password', :with => '1234test'
  #      fill_in 'login_password_confirmation', :with => '1234test'
  #      click_button 'Sign up'
  #    end
  #    sleep(1)
  #    within('#actor-type') do
  #      click_link 'Next'
  #    end
  #    select('gynecologist', :from => 'actor_information_medical_specialisations')
  #    click_link 'Next'
  #    page.should_not have_button("Create")
  #    click_link 'Sign out'
  # end
  #end

  context "with all required information" do
    it "updates an actor",:js => true do

      click_on 'Sign in'
      fill_in "login_email", :with => 'email@domain.ch'
      fill_in "login_password", :with => 'test1234'
      click_button 'Sign in'

      click_link 'Insel//BE'
      click_on "Edit actor"
      fill_in 'actor_information_canton', :with => 'SG'
      click_on "update"
      page.should have_content("successfully")
    end
  end

  context "with incomplete informatino" do
    it "does not update",:js => true do

      click_on 'Sign in'
      fill_in "login_email", :with => 'email@domain.ch'
      fill_in "login_password", :with => 'test1234'
      click_button 'Sign in'

      click_link 'Insel//BE'
      click_on "Edit actor"
      fill_in 'actor_information_canton', :with => ''
      click_on "update"
      page.should_not have_content("successfully")
    end
  end




end
