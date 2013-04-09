require 'spec_helper'

describe Scope do
  before {
    #create some scopes
    @scope = Scope.new
    @scope.key = :private
    @scope.name_translations = { :en => 'private', :de => 'privat', :it => 'privato', :fr => 'privé' }
    @scope.list = [:Self, :Admin]
    @scope.save
  }

  it 'creates a scope' do
    @scope.should_not be_nil
    @scope.should be_an_instance_of(Scope)
    @scope.should respond_to(:key)
    @scope.should respond_to(:name)
    @scope.should respond_to(:list)
  end
end