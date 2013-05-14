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

    #create a scope
    scope_public = BlacklistScope.new
    scope_public.key = :public_test
    scope_public.name_translations = { :en => 'public', :de => 'entlich', :it => 'pubblico', :frc=> 'public' }
    scope_public.list = []
    scope_public.save

    @scope_private = WhitelistScope.new
    @scope_private.key = :private_test
    @scope_private.name_translations = { :en => 'private', :de => 'privat', :it => 'privato', :fr => 'prive' }
    @scope_private.list = [:Self]
    @scope_private.save

    #create an information_field_type
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

    itype_name = InformationType.new
    itype_name.key = :name_test
    itype_name.information_field_type = information_field_text
    itype_name.name_translations = { :en => 'First name', :de =>'Vorname', :it => '??', :fr => '??' }
    itype_name.scope = scope_public
    itype_name.save

    itype_phone = InformationType.new
    itype_phone.key = :phone_test
    itype_phone.information_field_type = information_field_text
    itype_phone.name = "Telefon"
    itype_phone.scope = scope_public
    itype_phone.save

    #create some actor_types
    @atype_doctor = ActorType.new
    @atype_doctor.key = :doctor_test
    InformationTypeDecorator.create(info_medical_specialisations, @atype_doctor, true, true)
    InformationTypeDecorator.create(itype_name, @atype_doctor, false, true)
    InformationTypeDecorator.create(itype_phone, @atype_doctor, true, true)
    @atype_doctor.name_translations = { :en => 'Doctor', :de =>'Arzt', :it => 'Dottore', :fr => 'Mdecin' }
    @atype_doctor.to_string_pattern = "|:name_test|//|:phone_test|"
    @atype_doctor.save

    #create a user
    @user = User.new
    login = Login.new(:email => 'email5@domain.ch',
                      :password => 'test1234',
                      :password_confirmation => 'test1234')
    login.account = @user
    @user.save

    #create actor
    @actor = Actor.new
    @actor.actor_type = @atype_doctor

    @actor_name = Information.new
    @actor_name.scope = scope_public
    @actor_name.information_type_decorator = @actor.actor_type.decorator_by_key(:name_test)
    @actor_name.value = 'Name of our test actor'
    @actor_name.actor = @actor

    @actor_phone = Information.new
    @actor_phone.scope = scope_public
    @actor_phone.information_type_decorator = @actor.actor_type.decorator_by_key(:phone_test)
    @actor_phone.value = '033 666 77 88'
    @actor_phone.actor = @actor

    @user.actors.push(@actor)
    @actor.save
    @user.save

    #create actor2

    @actor2 = Actor.new
    @actor2.actor_type = @atype_doctor

    @actor_name2 = Information.new
    @actor_name2.scope = scope_public
    @actor_name2.information_type_decorator = @actor.actor_type.decorator_by_key(:name_test)
    @actor_name2.value = 'Name of our second test actor'
    @actor_name2.actor = @actor2

    @actor_phone2 = Information.new
    @actor_phone2.scope = scope_public
    @actor_phone2.information_type_decorator = @actor.actor_type.decorator_by_key(:phone_test)
    @actor_phone2.value = '345 434 49 95'
    @actor_phone2.actor = @actor2

    @user.actors.push(@actor2)
    @actor2.save
    @user.save

    #create relationship between actor and actor2
    @relation_works_with = RelationshipType.new
    @relation_works_with.key = :works_with_test
    @relation_works_with.name_translations = { :en => 'works with', :de =>'arbeitet mit', :it => '??', :fr => '??' }
    @relation_works_with.question_translations = {
        :en => 'With whom do you work?',
        :de => 'Mit wem arbeitet Ihr?',
        :it => '??',
        :fr => '??'
    }
    @relation_works_with.save

    @relationship1 = Relationship.new
    @relationship1.relationship_type = RelationshipType.find_by_key(:works_with_test)
    @relationship1.comment = 'This is another comment. Made by god! Creepy!'
    @relationship1.actor = @actor
    @relationship1.reference = @actor2
    @relationship1.save

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
      fill_in "login_email", :with => 'email5@domain.ch'
      fill_in "login_password", :with => 'test1234'
      click_button 'Sign in'
      click_link 'Name of our test actor//033 666 77 88'
      sleep(100000)

      click_on "Edit actor"
      fill_in 'actor_information_name_test', :with => 'Changed Name'
      click_on "update"
      sleep(5)
      page.should have_content("successfully")
      sleep(5)
    end
  end

  #context "with incomplete information" do
  #  it "should not update an actor",:js => true do
  #
  #    click_on 'Sign in'
  #    fill_in "login_email", :with => 'email5@domain.ch'
  #    fill_in "login_password", :with => 'test1234'
  #    click_button 'Sign in'
  #    click_link 'Name of our test actor//033 666 77 88'
  #
  #
  #    click_on "Edit actor"
  #    fill_in 'actor_information_name_test', :with => ''
  #    click_on "update"
  #    sleep(5)
  #    page.should_not have_content("successfully")
  #    sleep(5)
  #  end
  #end




end
