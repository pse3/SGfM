require 'spec_helper'

describe Relationship do
  before do
    # Create some relationship_types
    @relation_works_with = RelationshipType.new
    @relation_works_with.key = :works_with_test
    @relation_works_with.name_translations = { :en => 'works with', :de =>'arbeitet mit', :it => '??', :fr => '??' }
    @relation_works_with.save

    @relation_other = RelationshipType.new
    @relation_other.key = :other_test
    @relation_other.name_translations = { :en => 'other', :de =>'Andere', :it => '??', :fr => '??' }
    @relation_other.save

    #create some actor_types
    @atype_doctor = ActorType.new
    @atype_doctor.name = "Arzt"
    @atype_doctor.key = :doctor_test
    @atype_doctor.to_string_pattern = "|:name|//|:phone|"
    @atype_doctor.save

    #create some actors
    @actor_karl = Actor.new
    @actor_karl.actor_type = @atype_doctor
    @actor_peter = Actor.new
    @actor_peter.actor_type = @atype_doctor


    #create some relationships between karl and peter
    @relationship1 = Relationship.new
    @relationship1.relationship_type = @relation_works_with
    @relationship1.comment = 'This is a comment. Made by god!'
    @relationship1.actor = @actor_karl
    @relationship1.reference = @actor_peter
    @relationship1.save

    @relationship2 = Relationship.new
    @relationship2.relationship_type = @relation_other
    @relationship2.comment = 'This is also a comment. Made by me!'
    @relationship2.actor = @actor_peter
    @relationship2.reference = @actor_karl
    @relationship2.save
  end

  describe "#relationship" do
    subject{@relationship1}

    it{should_not be_nil}
    it{should be_valid}
    it{should be_an_instance_of(Relationship)}

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

    it 'stores comments' do
      @relationship1.comment.should_not be_nil
      @relationship2.comment.should_not be_nil
      expect(@relationship1.comment).to eq('This is a comment. Made by god!')
      expect(@relationship2.comment).to eq('This is also a comment. Made by me!')
    end

  end
end