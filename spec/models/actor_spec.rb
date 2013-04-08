require 'spec_helper'

describe Actor do
  before {
    #create some information_type
    itype_name = InformationType.new
    itype_name.name = "Name"
    itype_name.key = :name
    itype_name.save

    itype_phone = InformationType.new
    itype_phone.name = "Telefon"
    itype_phone.key = :phone
    itype_phone.save

    itype_address = InformationType.new
    itype_address.name = "Adresse"
    itype_address.key = :address
    itype_address.save

    itype_email = InformationType.new
    itype_email.name = "Email"
    itype_email.key = :email
    itype_email.save

    #create some actor_types
    @atype_doctor = ActorType.new
    @atype_doctor.name = "Arzt"
    @atype_doctor.key = :doctor
    InformationTypeDecorator.create(itype_name, @atype_doctor, true, true)
    InformationTypeDecorator.create(itype_phone, @atype_doctor, true, true)
    InformationTypeDecorator.create(itype_address, @atype_doctor, true, true)
    InformationTypeDecorator.create(itype_email, @atype_doctor, true, true)
    @atype_doctor.save

    #create actor
    @actor = Actor.new
    @actor.actor_type = @atype_doctor
  }


  describe "Actor" do

    it "creates an actor" do
      actor_new = Actor.new
      actor_new.should_not be_nil
      actor_new.should respond_to(:actor_type)
      actor_new.should respond_to(:informations)
    end

    it "sets correct time of creation when initializing" do
      @actor.created_at.should be_within(10).of(DateTime.now)
    end

    it "assigns actor_type to actor" do
      @actor.actor_type = @atype_doctor
      @actor.actor_type.should equal(@atype_doctor)
    end

    it "adds an information to actor" do
      information = Information.new
      information_type_decorator = @actor.actor_type.decorator_by_key(:name)
      information.information_type_decorator = information_type_decorator
      information.value = "Peter"
      information.actor = @actor
      @actor.informations.should include("Peter")
    end
    it "adds a relationship to actor"
    it "finds informations by key"
    it "finds relationships by key"
    it "displays correct to_string_field"
    it "updates to_string_field"
    it "updates search_field"



    it "should update value of information" do

    end
  end

end