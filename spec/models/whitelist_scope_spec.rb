require 'spec_helper'

describe WhitelistScope do
  before do
    @scope_whitelist_test = WhitelistScope.new
    @scope_whitelist_test.key = :public_scope_test
    @scope_whitelist_test.name_translations = { :en => 'public', :de => 'oeffentlich', :it => 'pubblico', :frc=> 'public' }
    @scope_whitelist_test.list = [:User]
    @scope_whitelist_test.save

    #create the information field types
    information_field_text = InformationFieldText.new
    information_field_text.key = :text_test
    information_field_text.name_translations = { :en => 'Text field', :de => 'Textfeld', :it => '???', :fr => '???' }
    information_field_text.save

    #create the information
    @information_whitelist_test = Information.new
    @information_whitelist_test.scope = @scope_whitelist_test

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

  subject{@scope_whitelist_test}

  it{should be_valid}
  it{should_not be_nil}

  it 'inherits from scope' do
    BlacklistScope.should < Scope
  end

  let(:visible){@scope_whitelist_test.visible?(:Admin,@information_whitelist_test)}
  specify {visible.should_not be_true}

  let(:visible2){@scope_whitelist_test.visible?(:User,@information_whitelist_test)}
  specify {visible2.should be_true}

end