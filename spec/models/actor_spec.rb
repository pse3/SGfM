require 'spec_helper'

describe Actor, 'test creation' do
  it 'should pass the name' do
    actor = Actor.create(:name => 'Patrick Suter')
    actor.name.should_not be_nil
    actor.name.should eql 'Patrick Suter'
  end
end
