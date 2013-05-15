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
     sleep(1)
     click_on 'Add Information Type'
     page.all("#information_type_decorator_information_type")[1].select("First name")
     page.all("#information_type_decorator_required")[1].select("Yes")
     page.all("#information_type_decorator_searchable")[1].select("Yes")
     sleep(1)
     click_on 'Add Information Type'
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
    page.all("a")[17].click #clicks on the 17th link on the page
    fill_in 'actor_type_name[en]', :with => 'NewNameOfTestActorType'
    click_on 'update'
    page.should have_content("uccessfully")
    page.should have_content("NewNameOfTestActorType")
    page.should_not have_content("Doctor")
    click_on 'Sign out'

  end

end
