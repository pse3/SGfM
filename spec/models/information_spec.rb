require 'spec_helper'

describe Information do
  it 'should inherit the scope' do
    info = Information.new
    info_type = InformationType.new
    info_type.scope = Scope.new
    info.scope.should be_nil
    info.information_type = info_type
    info.scope.should == info_type.scope
    info.information_type.should == info_type
  end
end