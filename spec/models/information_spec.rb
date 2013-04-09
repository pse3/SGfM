require 'spec_helper'

describe Information do
  before {
    #create an actor type
    @atype = ActorType.new
    @atype.key = :doctor
    @atype.save

    #create an information type
    @itype = InformationType.new
    @itype.key = :name
    @itype.information_field_type = InformationFieldText.new
    @itype.save

    #create an information type decorator
    @itypedec = InformationTypeDecorator.create(@itype, @atype, true, true)

    #create an information
    @information = Information.new
  }

  it "creates an information" do
    @information.should_not be_nil
  end

  it "adds an information type decorator to an information" do
    @information.information_type_decorator = @itypedec
    @information.information_type_decorator.should_not be_nil
    @information.information_type_decorator.should be_an_instance_of(InformationTypeDecorator)
    @information.information_type_decorator.should be(@itypedec)
  end
  it "adds a value to an information" do
    @information.value = ('value')
    @information.value.should equal('value')
  end
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