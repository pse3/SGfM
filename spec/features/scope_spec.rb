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
    select 'WhitelistScope', :from => 'scope__type'
    fill_in 'scope_name[en]', :with => 'TestScopeEnglish'
    fill_in 'scope_name[de]', :with => 'TestScopeGerman'
    fill_in 'scope_name[fr]', :with => 'TestScopeFrench'
    fill_in 'scope_name[it]', :with => 'TestScopeItalian'
    fill_in 'scope_key', :with => 'TestScopeKey'
    click_on 'Create'
    page.should have_content('TestScopeEnglish')
    page.should have_content('uccessfully')
  end

  it 'updates a scope'
  it 'destroys a scope'

end
