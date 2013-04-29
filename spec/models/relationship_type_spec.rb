require 'spec_helper'

describe RelationshipType do

  before do
    #create some relationship_types
    @relation_works_with = RelationshipType.new
    @relation_works_with.key = :works_with_test
    @relation_works_with.name_translations = { :en => 'works with', :de =>'arbeitet mit', :it => '??', :fr => '??' }
    @relation_works_with.question = {:en => 'english question', :de => 'german question', :it => '??', :fr => '??'}
    @relation_works_with.save
  end

  subject{@relation_works_with}

  it {should be_valid}
  it {should_not be_nil}
  it {should be_an_instance_of(RelationshipType)}
  it {should respond_to(:key)}
  it {should respond_to(:name_translations)}
  it {should respond_to(:question)}

  let(:found_user) { RelationshipType.find_by_key(:works_with_test) }
  specify { found_user.should eq(@relation_works_with)}

end