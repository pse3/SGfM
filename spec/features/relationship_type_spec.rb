require 'spec_helper'

#Capybara.match = :first

describe "Scope" do

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

    scope_public = BlacklistScope.new
    scope_public.key = :public
    scope_public.name_translations = { :en => 'public', :de => 'oeffentlich', :it => 'pubblico', :frc=> 'public' }
    scope_public.list = []
    scope_public.save

    #creates an admin

    admin = Admin.new
    login = Login.new(:email => 'admin@domain.ch',
                      :password => 'test1234',
                      :password_confirmation => 'test1234')
    login.account = admin
    admin.save
    login.save

    visit '/'
  end

  it 'creates a relationship type'
  it 'updates a relationship type'
  it 'destroys a relationship type'

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

  it 'is updated', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'Scopes'
    page.should have_content("public")
    page.first(".icon-edit").click
    fill_in 'edited_scope_name[en]', :with => 'UpdatedTestScopeName'
    click_on 'Save'
    page.should have_content("uccessfully")
    page.should have_content("UpdatedTestScopeName")
    page.should_not have_content("TestScopeEnglish")
    click_on 'Sign out'
  end

  it 'is destroyed', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'Scopes'
    page.should have_content('public')
    page.first(".icon-trash").click
    page.driver.browser.switch_to.alert.accept
    page.should have_content("uccessfully")
    page.should have_content("deleted")
    page.should_not have_content("public")
    click_on 'Sign out'
  end

end
