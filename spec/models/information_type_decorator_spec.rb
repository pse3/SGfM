require 'spec_helper'

describe InformationTypeDecorator do
  before do
    #create an information_type
    @itype_name = InformationType.new
    @itype_name.key = :name_test
    @itype_name.name = "Name"
    @itype_name.save

    #create an actor_type
    @atype_doctor = ActorType.new
    @atype_doctor.name = "Arzt"
    @atype_doctor.key = :doctor_test
    @atype_doctor.save

    #create some information_type_decorators
    @itypedec_name = InformationTypeDecorator.create(@itype_name, @atype_doctor, true, true)

  end

  subject{@itypedec_name}
  it{should_not be_nil}
  it{should be_an_instance_of(InformationTypeDecorator)}

  it "directs missing methods to its information type" do
    @itypedec_name.key.should be(@itype_name.key)
    @itypedec_name.name.should be(@itype_name.name)
  end
end