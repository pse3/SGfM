require 'spec_helper'

describe ActorType do
  before do
    #create some information_types
    @itype_name = InformationType.new
    @itype_name.name = "Name"
    @itype_name.key = :name_test
    @itype_name.save

    @itype_phone = InformationType.new
    @itype_phone.name = "Telefon"
    @itype_phone.key = :phone_test
    @itype_phone.save

    @itype_address = InformationType.new
    @itype_address.name = "Adresse"
    @itype_address.key = :address_test
    @itype_address.save

    @itype_email = InformationType.new
    @itype_email.name = "Email"
    @itype_email.key = :email_test
    @itype_email.save

    #create some actor_types
    @atype_doctor = ActorType.new
    @atype_doctor.name = 'Arzt'
    @atype_doctor.key = :doctor_test
    @itypedec_name = InformationTypeDecorator.create(@itype_name, @atype_doctor, true, true)
    @itypedec_phone = InformationTypeDecorator.create(@itype_phone, @atype_doctor, true, true)
    InformationTypeDecorator.create(@itype_address, @atype_doctor, true, true)
    InformationTypeDecorator.create(@itype_email, @atype_doctor, true, true)
    @atype_doctor.to_string_pattern = "|:name|//|:phone|"
    @atype_doctor.save

    @atype_hospital = ActorType.new
    @atype_hospital.name = 'Spital'
    @atype_hospital.key = :hospital_test
    InformationTypeDecorator.create(@itype_name, @atype_hospital, true, true)
    InformationTypeDecorator.create(@itype_phone, @atype_hospital, true, true)
    InformationTypeDecorator.create(@itype_address, @atype_hospital, true, true)
    @atype_hospital.to_string_pattern = "|:name|//|:phone|"
    @atype_hospital.save

    #create an actor
    @actor = Actor.new
    @actor.actor_type = @atype_doctor
  end

  describe '#actor' do

    subject{@actor}

    it {should be_valid}
    it {should_not be_nil}

    let(:actor_type){@actor.actor_type}
    specify {actor_type.should eq(@atype_doctor)}

    let(:atype_name){@atype_doctor.name}
    specify {atype_name.should eq('Arzt')}
  end

  describe "#actor_type" do
    it "assigns a key for an actor type" do
      @atype_doctor.key.should be(:doctor_test)
      @atype_hospital.key.should be(:hospital_test)
    end

    it "finds actor type by key" do
      expect(ActorType.find_by_key(:doctor_test)).to eq(@atype_doctor)
      expect(ActorType.find_by_key(:hospital_test)).to eq(@atype_hospital)
    end

    it "has information type decorators" do
      @atype_doctor.information_type_decorators.should include(@itypedec_name)
      @atype_doctor.information_type_decorators.should include(@itypedec_phone)
    end

    it 'hast information types' do
      @atype_doctor.information_types.should include(@itype_name)
      @atype_doctor.information_types.should include(@itype_phone)
    end

  end


  describe '.decorator_by_key' do
    it "returns decorator by information type key" do
      @atype_doctor.decorator_by_key(:name_test).should be(@itypedec_name)
      @atype_doctor.decorator_by_key(:phone_test).should be(@itypedec_phone)
    end
  end

end