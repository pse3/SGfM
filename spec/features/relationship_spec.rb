require 'spec_helper'

#Capybara.match = :first

describe "Relationship" do

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

    # Dummy doctor1
    dummy_actor_test_doctor = Actor.new
    dummy_actor_test_doctor.actor_type = ActorType.find_by_key(:doctor)
    dummy_actor_type = dummy_actor_test_doctor.actor_type

    test_doctor_fname = Information.new
    test_doctor_fname.information_type_decorator = dummy_actor_type.decorator_by_key(:first_name)
    test_doctor_fname.value = 'TestDoctor1FirstName'
    test_doctor_fname.actor = dummy_actor_test_doctor

    user.actors.push(dummy_actor_test_doctor)
    dummy_actor_test_doctor.save
    user.save

    # Dummy doctor1
    dummy_actor_test_doctor2 = Actor.new
    dummy_actor_test_doctor2.actor_type = ActorType.find_by_key(:doctor)
    dummy_actor_type = dummy_actor_test_doctor2.actor_type

    test_doctor_fname = Information.new
    test_doctor_fname.information_type_decorator = dummy_actor_type.decorator_by_key(:first_name)
    test_doctor_fname.value = 'TestDoctor2FirstName'
    test_doctor_fname.actor = dummy_actor_test_doctor2

    user.actors.push(dummy_actor_test_doctor2)
    dummy_actor_test_doctor2.save
    user.save

    # Create some Relations
    relationship_test = Relationship.new
    relationship_test.relationship_type = RelationshipType.find_by_key(:works_with)
    relationship_test.scope = scope_public
    relationship_test.comment = 'This is a comment. Made by god!'
    relationship_test.actor = dummy_actor_test_doctor
    relationship_test.reference = dummy_actor_test_doctor2
    relationship_test.save

    visit '/'
  end

  it "is created",:js => true do

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
    fill_in "actor_information_first_name", :with => 'NewTestDoctorFirstName'
    click_link 'Next'
    click_button 'Create'

    click_on 'Add relationship'
    find(".select2-offscreen").set("T")
    sleep(0.5)
    find(".select2-input").set("TestDoctor1FirstName")
    find(".select2-input").native.send_keys(:return)
    click_button 'create'
    page.should have_content("uccessfully")
    page.should have_content("NewTestDoctorFirstName")
    click_on 'Sign out'
  end

  it 'is updated', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'email@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'TestDoctor1FirstName'
    page.should have_content('works with')
    page.should have_content('Made by god')
    page.first(".icon-edit").click
    select('assign to', :from => 'relationship_relationship_type')
    fill_in 'relationship_comment', :with => 'This is a NEW comment; made by Rafael'
    click_on 'update'
    page.should have_content('assign to')
    page.should have_content('made by Rafael')
    page.should have_content('uccessfully')
    page.should_not have_content('works with')
    page.should_not have_content('Made by god')
    click_on 'Sign out'
  end

  it 'is destroyed', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'email@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'TestDoctor1FirstName'
    page.should have_content('works with')
    sleep(0.5)
    page.first(".icon-trash").click
    page.should have_content("uccessfully")
    page.should have_content("deleted")
    page.should_not have_content("works with")
    click_on 'Sign out'
  end

end
