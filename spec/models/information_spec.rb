require 'spec_helper'

describe Information do

  it "creates an information" do
    information = Information.new
    information.should_not be_nil
  end

  it "adds an information type decorator to an information"
  it "adds a value to an information"
  it 'inherits the scope' do
    info = Information.new
    info_type = InformationType.new
    info_type.scope = Scope.new
    info.scope.should be_nil
    info.information_type = info_type
    info.scope.should == info_type.scope
    info.information_type.should == info_type
  end
end