require 'spec_helper'

describe "ActorType" do
  before {
    #create some information_type
    @itype_name = InformationType.new
    @itype_name.name = "Name"
    @itype_name.key = :name
    @itype_name.save

    @itype_phone = InformationType.new
    @itype_phone.name = "Telefon"
    @itype_phone.key = :phone
    @itype_phone.save

    @itype_address = InformationType.new
    @itype_address.name = "Adresse"
    @itype_address.key = :address
    @itype_address.save

    @itype_email = InformationType.new
    @itype_email.name = "Email"
    @itype_email.key = :email
    @itype_email.save

    #create some actor_types
    @atype_doctor = ActorType.new
    @atype_doctor.name = 'Arzt'
    @atype_doctor.key = :doctor
    @itypedec_name = InformationTypeDecorator.create(@itype_name, @atype_doctor, true, true)
    @itypedec_phone = InformationTypeDecorator.create(@itype_phone, @atype_doctor, true, true)
    InformationTypeDecorator.create(@itype_address, @atype_doctor, true, true)
    InformationTypeDecorator.create(@itype_email, @atype_doctor, true, true)
    @atype_doctor.save

    @atype_hospital = ActorType.new
    @atype_hospital.name = 'Spital'
    @atype_hospital.key = :hospital
    InformationTypeDecorator.create(@itype_name, @atype_hospital, true, true)
    InformationTypeDecorator.create(@itype_phone, @atype_hospital, true, true)
    InformationTypeDecorator.create(@itype_address, @atype_hospital, true, true)
    @atype_hospital.save

    #create actor
    @actor = Actor.new
    @actor.actor_type = @atype_doctor
  }
  it 'creates an actor type' do
    @atype_doctor.should_not be_nil
  end
  it "assigns a key for an actor type" do
    @atype_doctor.key.should be(:doctor)
    @atype_hospital.key should be(:hospital)
  end
  it "assigns a name for an actor type" do
    expect(@atype_doctor.name).to eq('Arzt')
  end
  it "finds actor type by key" do
    ActorType.find_by_key(:doctor).should be(@atype_doctor)
  end
  it "has information type decorators" do
    @atype_doctor.information_type_decorators.should include(@itypedec_name)
    @atype_doctor.information_type_decorators.should include(@itypedec_phone)
  end
  it 'returns information types' do
    @atype_doctor.information_types.should include(@itype_name)
    @atype_doctor.information_types.should include(@itype_phone)
  end
  it "returns decorator by information type key" do
    @atype_doctor.decorator_by_key(:name).should be(@itypedec_name)
    @atype_doctor.decorator_by_key(:phone).should be(@itypedec_phone)
  end
  it "updates corresponding actors"
end