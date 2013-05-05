require 'spec_helper'

describe InformationType do
  before do
    #create some information_types
    @itype_name = InformationType.new
    @itype_name.key = :name_test
    @itype_name.name = "Name"
    @itype_name.save
  end

  subject{@itype_name}

  it{should be_valid}
  it{should_not be_nil}
  it{should be_an_instance_of(InformationType)}

  describe ".find_by_key" do
    it "finds information" do
      expect(InformationType.find_by_key(:name_test)).to eq(@itype_name)
    end
  end
end