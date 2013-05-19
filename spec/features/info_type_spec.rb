require 'spec_helper'

#Capybara.match = :first

describe "Info type" do

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

    #create the information field types
    information_field_text = InformationFieldText.new
    information_field_text.key = :text
    information_field_text.name_translations = { :en => 'Text field', :de => 'Textfeld', :it => '???', :fr => '???' }
    information_field_text.save

    information_field_multiple_select = InformationFieldMultipleSelect.new
    information_field_multiple_select.key = :multiple_select
    information_field_multiple_select.name_translations = { :en => 'multiple selection', :de => 'Mehrauswahl', :it => '???', :fr => '???' }
    information_field_multiple_select.save

    #creates information type company
    info_company = InformationType.new
    info_company.key = :company
    info_company.information_field_type = information_field_text
    info_company.name_translations = { :en => 'Company', :de =>'Firma', :it => '??', :fr => '??' }
    info_company.scope = scope_public
    info_company.save


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


  it 'is created', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'InformationTypes'
    click_on 'Create new information type'
    fill_in 'information_type_name[en]', :with => 'TestInformationTypeEnglish'
    fill_in 'information_type_name[de]', :with => 'TestInformationTypeGerman'
    fill_in 'information_type_name[fr]', :with => 'TestInformationTypeFrench'
    fill_in 'information_type_name[it]', :with => 'TestInformationTypeItalian'
    fill_in 'information_type_key', :with => 'TestInfoTypeKey'
    select('Text field', :from => 'data-select')
    click_on 'Create'
    page.should have_content('TestInformationTypeEnglish')
    page.should have_content('uccessfully')
  end

  it 'is updated', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'InformationTypes'
    page.should have_content('Company')
    page.first(".icon-edit").click
    fill_in 'information_type_edited_name[en]', :with => 'UpdatedTestInformationTypeName'
    click_on 'Edit'
    page.should have_content("uccessfully")
    page.should have_content("UpdatedTestInformationTypeName")
    page.should_not have_content("Company")
    click_on 'Sign out'
  end

  it 'is destroyed', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'InformationTypes'
    page.should have_content('Company')
    page.first(".icon-trash").click
    page.driver.browser.switch_to.alert.accept
    page.should have_content("uccessfully")
    page.should have_content("deleted")
    page.should_not have_content("Company")
    click_on 'Sign out'
  end

end
