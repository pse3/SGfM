require 'spec_helper'

describe InformationType do
  before {
    #create some information_types
    @itype_name = InformationType.new
    @itype_name.key = :name
    @itype_name.name = "Name"
    @itype_name.save

    @itype_phone = InformationType.new
    @itype_phone.key = :phone
    @itype_phone.name = "Telefon"
    @itype_phone.save
  }

  it "creates an information type" do
    @itype_name.should_not be_nil
    @itype_phone.should_not be_nil
    @itype_name.should be_an_instance_of(InformationType)
    @itype_phone.should be_an_instance_of(InformationType)
  end

  it "finds information type by key" do
    expect(InformationType.find_by_key(:name)).to eq(@itype_name)
    expect(InformationType.find_by_key(:phone)).to eq(@itype_phone)
  end

end