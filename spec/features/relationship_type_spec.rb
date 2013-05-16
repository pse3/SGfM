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
    click_on 'RelationshipTypes'
    click_on 'Create new RelationshipType'
    fill_in 'relationship_type_name_translations[en]', :with => 'TestRelationshipTypeEnglish'
    fill_in 'relationship_type_name_translations[de]', :with => 'TestRelationshipTypeGerman'
    fill_in 'relationship_type_name_translations[fr]', :with => 'TestRelationshipTypeFrench'
    fill_in 'relationship_type_name_translations[it]', :with => 'TestRelationshipTypeItalian'
    fill_in 'relationship_type_question_translations[en]', :with => 'TestRelationshipTypeQuestionEnglish'
    fill_in 'relationship_type_question_translations[de]', :with => 'TestRelationshipTypeQuestionGerman'
    fill_in 'relationship_type_question_translations[fr]', :with => 'TestRelationshipTypeQuestionFrench'
    fill_in 'relationship_type_question_translations[it]', :with => 'TestRelationshipTypeQuestionItalian'
    click_on 'Create'
    page.should have_content('TestRelationshipTypeEnglish')
    page.should have_content('uccessfully')
  end

  it 'is updated', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'RelationshipTypes'
    page.should have_content("works with")
    page.first(".icon-edit").click
    fill_in 'relationship_type_name_translations[en]', :with => 'NewEnglishRelationshipTypeName'
    click_on 'update'
    page.should have_content("uccessfully")
    page.should have_content("NewEnglishRelationshipTypeName")
    page.should_not have_content("works with")
    click_on 'Sign out'
  end

  it 'is destroyed', :js => true do
    click_on 'Sign in'
    fill_in "login_email", :with => 'admin@domain.ch'
    fill_in "login_password", :with => 'test1234'
    click_button 'Sign in'
    click_on 'RelationshipTypes'
    page.should have_content('works with')
    page.first(".icon-trash").click
    page.driver.browser.switch_to.alert.accept
    page.should have_content("uccessfully")
    page.should have_content("deleted")
    page.should_not have_content("works with")
    click_on 'Sign out'
  end

end
