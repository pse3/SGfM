require 'spec_helper'

describe Actor do
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
    @atype_doctor.name = "Arzt"
    @atype_doctor.key = :doctor
    @atype_doctor.information_type.push(InformationType.find_by_key(:name))
    @atype_doctor.information_type.push(InformationType.find_by_key(:phone))
    @atype_doctor.information_type.push(InformationType.find_by_key(:address))
    @atype_doctor.information_type.push(InformationType.find_by_key(:email))
    @atype_doctor.save

  }

  describe "Actor" do
    it "should add type to actor" do
      @actor = Actor.new

      @actor.should respond_to(:actor_type)
      @actor.should respond_to(:informations)

      @actor.actor_type = @atype_doctor
      @actor.actor_type.should equal(@atype_doctor)
    end
  end

end