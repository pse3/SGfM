require 'spec_helper'

describe "RelationshipType" do
  before {
    @relation_works_with = RelationshipType.new
    @relation_works_with.key = :works_with
    @relation_works_with.name_translations = { :en => 'works with', :de =>'arbeitet mit', :it => '??', :fr => '??' }
    @relation_works_with.save

    @relation_other = RelationshipType.new
    @relation_other.key = :other
    @relation_other.name_translations = { :en => 'other', :de =>'Andere', :it => '??', :fr => '??' }
    @relation_other.save
  }

  it "creates relationship type" do
    @relation_works_with.should_not be_nil
    @relation_works_with.should be_an_instance_of(RelationshipType)
  end
  it "finds relationship type by key" do
    expect(RelationshipType.find_by_key(:works_with)).to eq(@relation_works_with)
    expect(RelationshipType.find_by_key(:other)).to eq(@relation_other)
  end
end