require 'spec_helper'

describe BlacklistScope do
  before {
  }

  it 'inherits from scope' do
    BlacklistScope.should < Scope
  end

  it 'isnt visible to viewers in blacklist'
  it 'is visible to viewers not in blacklist'

end