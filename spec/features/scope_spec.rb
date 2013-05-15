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

  it 'is created', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'Scopes'
    click_on 'Create new Scope'
    page.all("a")[17].click #clicks on the 17th link on the page
    fill_in 'actor_type_name[en]', :with => 'NewNameOfTestActorType'
    click_on 'update'
    page.should have_content("uccessfully")
    page.should have_content("NewNameOfTestActorType")
    page.should_not have_content("Doctor")
    click_on 'Sign out'

  end

end
