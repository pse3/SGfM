require 'spec_helper'

describe BlacklistScope do
  before do
    @scope_blacklist_test = BlacklistScope.new
    @scope_blacklist_test.key = :public_scope_test
    @scope_blacklist_test.name_translations = { :en => 'public', :de => 'oeffentlich', :it => 'pubblico', :frc=> 'public' }
    @scope_blacklist_test.list = [:User]
    @scope_blacklist_test.save

    #create the information field types
    information_field_text = InformationFieldText.new
    information_field_text.key = :text_test
    information_field_text.name_translations = { :en => 'Text field', :de => 'Textfeld', :it => '???', :fr => '???' }
    information_field_text.save

    #create the information
    @information_test = Information.new
    @information_test.scope = @scope_blacklist_test

    @user1 = User.new
    @login = Login.new(:email => 'email@domain.ch',
                      :password => 'test1234',
                      :password_confirmation => 'test1234')
    @login.account = @user1
    @user1.save
    #@login.save

    @admin = Admin.new
    @login = Login.new(:email => 'admin@domain.ch',
                      :password => 'test1234',
                      :password_confirmation => 'test1234')
    @login.account = @admin
    @admin.save
    #@login.save

  end

  subject{@scope_blacklist_test}

  it{should be_valid}
  it{should_not be_nil}

  it 'inherits from scope' do
    BlacklistScope.should < Scope
  end

  context "when account type is on blacklist" do
    let(:visible){@scope_blacklist_test.visible?(:User,@information_test)}
    specify {visible.should_not be_true}
  end
  context "when account type is not on blacklist" do
    let(:visible2){@scope_blacklist_test.visible?(:Admin,@information_test)}
    specify {visible2.should be_true}
  end

end