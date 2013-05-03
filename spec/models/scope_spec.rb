require 'spec_helper'

describe Scope do
  before do
    #create a scope
    @scope = Scope.new
    @scope.name = 'Testscope'
    @scope.key = :test_scope
    @scope.list = []
    @scope.save
  end

  subject{@scope}

  it{should_not be_nil}
  it{should be_valid}
  it{should respond_to(:key)}
  it{should respond_to(:name)}
  it{should respond_to(:list)}
  it 'should be an instance of Scope' do
    @scope.should be_an_instance_of(Scope)
  end

end