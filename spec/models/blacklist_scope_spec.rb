require 'spec_helper'

describe BlacklistScope do
  before do
    @scope_public_test = BlacklistScope.new
    @scope_public_test.key = :public
    @scope_public_test.name_translations = { :en => 'public', :de => 'oeffentlich', :it => 'pubblico', :frc=> 'public' }
    @scope_public_test.list = []
    @scope_public_test.save
  end

  subject{@scope_public_test}

  it{should be_valid}
  it{should_not be_nil}

  it 'inherits from scope' do
    BlacklistScope.should < Scope
  end



  it 'isnt visible to viewers in blacklist'
  it 'is visible to viewers not in blacklist'

end