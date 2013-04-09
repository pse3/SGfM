require 'spec_helper'

describe "Relationship" do
  before {
    # Create some RelationshipTypes
    @relation_works_with = RelationshipType.new
    @relation_works_with.key = :works_with
    @relation_works_with.name_translations = { :en => 'works with', :de =>'arbeitet mit', :it => '??', :fr => '??' }
    @relation_works_with.save

    @relation_other = RelationshipType.new
    @relation_other.key = :other
    @relation_other.name_translations = { :en => 'other', :de =>'Andere', :it => '??', :fr => '??' }
    @relation_other.save

    #create some actors
    @actor_karl = Actor.new
    @actor_peter = Actor.new

    #create some relationships between karl and peter
    @relationship1 = Relationship.new
    @relationship1.relationship_type = RelationshipType.find_by_key(:works_with)
    @relationship1.comment = 'This is a comment. Made by god!'
    @relationship1.actor = @actor_karl
    @relationship1.reference = @actor_peter
    @relationship1.save

    @relationship2 = Relationship.new
    @relationship2.relationship_type = RelationshipType.find_by_key(:other)
    @relationship2.comment = 'This is also a comment. Made by me!'
    @relationship2.actor = @actor_peter
    @relationship2.reference = @actor_karl
    @relationship2.save
  }

  it "creates a relationship" do
    @relationship1.should_not be_nil
    @relationship2.should_not be_nil
    @relationship1.should be_an_instance_of(Relationship)
    @relationship2.should be_an_instance_of(Relationship)
  end
  it "sets correct time of creation" do
    @relationship1.created_at.should be_within(10).of(DateTime.now)
    @relationship2.created_at.should be_within(10).of(DateTime.now)
  end
  it "stores correct actors" do
    @relationship1.actor.should be(@actor_karl)
    @relationship2.actor.should be(@actor_peter)
    @relationship1.reference.should be(@actor_peter)
    @relationship2.reference.should be(@actor_karl)
  end

end