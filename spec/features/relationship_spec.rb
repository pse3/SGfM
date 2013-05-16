require 'spec_helper'

#Capybara.match = :first

describe "Actor" do

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

   info_first_name = InformationType.new
    info_first_name.key = :first_name
    info_first_name.information_field_type = information_field_text
    info_first_name.name_translations = { :en => 'First name', :de =>'Vorname', :it => '??', :fr => '??' }
    info_first_name.scope = scope_public
    info_first_name.save

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
    InformationTypeDecorator.create(info_first_name, actor_doctor,  true, true)
    actor_doctor.name_translations = { :en => 'Doctor', :de =>'Arzt', :it => 'Dottore', :fr => 'Medecin' }
    actor_doctor.to_string_pattern = '|:first_name|'
    actor_doctor.save    user = User.new
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

    # Dummy doctor 'Karl Schürch'
    dummy_actor_test_doctor = Actor.new
    dummy_actor_test_doctor.actor_type = ActorType.find_by_key(:doctor)
    dummy_actor_type = dummy_actor_test_doctor.actor_type

    test_doctor_fname = Information.new
    test_doctor_fname.information_type_decorator = dummy_actor_type.decorator_by_key(:first_name)
    test_doctor_fname.value = 'TestDoctorFirstName'
    test_doctor_fname.actor = dummy_actor_test_doctor

    user.actors.push(dummy_actor_test_doctor)
    dummy_actor_test_doctor.save
    user.save

    visit '/'
  end

  it 'creates a relationship'
  it 'updates a relationship'
  it 'destroys a relationship'

  it "adds a relationship",:js => true do

    click_link "Sign up"
    within('#new_login') do
      fill_in 'login_email', :with => 'test_1@test.de'
      fill_in 'login_password', :with => '1234test'
      fill_in 'login_password_confirmation', :with => '1234test'
      click_button 'Sign up'
    end
    sleep(0.5)
    within('#actor-type') do
      click_link 'Next'
    end
    fill_in "actor_information_first_name", :with => 'SecondDoctorTestFirstname'
    click_link 'Next'
    click_button 'Create'

    click_on 'Add relationship'
    sleep(100)
    find(".select2-offscreen").set("T")
    sleep(0.5)
    find(".select2-input").set("TestDoctorFirstName")
    find(".select2-input").native.send_keys(:return)
    click_button 'create'
    page.should have_content("uccessfully")
    page.should have_content("TestDoctorFirstname")
  end




end
