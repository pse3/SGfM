require 'spec_helper'

describe Information do
  before do
    #create an actor_type
    @atype = ActorType.new
    @atype.key = :doctor_test
    @atype.save

    #create an information_type
    @itype = InformationType.new
    @itype.key = :street_test
    @itype.name = 'Street'
    @itype.information_field_type = InformationFieldText.new
    @itype.save

    #create an information_type_decorator
    @itypedec = InformationTypeDecorator.create(@itype, @atype, true, true)

    #create an information
    @information = Information.new
  end

  subject{@information}

  it{should_not be_nil}
  it "adds an information type decorator to an information" do
    @information.information_type_decorator = @itypedec
    @information.information_type_decorator.should_not be_nil
    @information.information_type_decorator.should be_an_instance_of(InformationTypeDecorator)
    @information.information_type_decorator.should be(@itypedec)
  end
  it "adds a value to an information" do
    @information.information_type_decorator = @itypedec
    @information.value = 'value'
    expect(@information.value).to eq('value')
  end
  it 'inherits the scope' do
    info = Information.new
    info_type = InformationType.new
    info_type.scope = Scope.new
    info.scope.should be_nil
    info.information_type_decorator = info_type
    info.scope.should == info_type.scope
    info.information_type_decorator.should == info_type
  end



end