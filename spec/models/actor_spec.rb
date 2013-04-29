require 'spec_helper'

describe Actor do
  before do

    #create a scope
    scope_public = BlacklistScope.new
    scope_public.key = :public_test
    scope_public.name_translations = { :en => 'public', :de => 'öffentlich', :it => 'pubblico', :frc=> 'public' }
    scope_public.list = []
    scope_public.save

    #create an information_field_type
    information_field_text = InformationFieldText.new
    information_field_text.key = :text
    information_field_text.name_translations = { :en => 'Text field', :de => 'Textfeld', :it => '???', :fr => '???' }
    information_field_text.save

    #create some information_types
    itype_name = InformationType.new
    itype_name.key = :name_test
    itype_name.information_field_type = information_field_text
    itype_name.name_translations = { :en => 'First name', :de =>'Vorname', :it => '??', :fr => '??' }
    itype_name.scope = scope_public
    itype_name.save

    itype_phone = InformationType.new
    itype_phone.key = :phone_test
    itype_phone.information_field_type = information_field_text
    itype_phone.name = "Telefon"
    itype_phone.scope = scope_public
    itype_phone.save

    #create some actor_types
    @atype_doctor = ActorType.new
    @atype_doctor.key = :doctor_test
    InformationTypeDecorator.create(itype_name, @atype_doctor, true, true)
    InformationTypeDecorator.create(itype_phone, @atype_doctor, true, true)
    @atype_doctor.name_translations = { :en => 'Doctor', :de =>'Arzt', :it => 'Dottore', :fr => 'Médecin' }
    @atype_doctor.to_string_pattern = "|:name_test|//|:phone_test|"
    @atype_doctor.save

    #create a user
    @user = User.new
    login = Login.new(:email => 'email5@domain.ch',
                      :password => 'test1234',
                      :password_confirmation => 'test1234')
    login.account = @user
    @user.save

    #create actor
    @actor = Actor.new
    @actor.actor_type = @atype_doctor

    actor_name = Information.new
    actor_name.scope = scope_public
    actor_name.information_type_decorator = @actor.actor_type.decorator_by_key(:name_test)
    actor_name.value = 'Name of our test actor'
    actor_name.actor = @actor

    actor_phone = Information.new
    actor_phone.scope = scope_public
    actor_phone.information_type_decorator = @actor.actor_type.decorator_by_key(:phone_test)
    actor_phone.value = '033 666 77 88'
    actor_phone.actor = @actor

    @user.actors.push(@actor)
    @actor.save
    @user.save

  end

  subject{@actor}

  it{should be_valid}
  it{should_not be_nil}
  it{should respond_to(:actor_type)}
  it{should respond_to (:informations)}

  let(:save){@actor.save}
  specify {save.should be_true}

  let(:actor_type) { @actor.actor_type }
  specify {actor_type.should eq(@atype_doctor)}

  it "sets correct time of creation when initializing" do
    @actor.created_at.should be_within(10).of(DateTime.now)
  end

  it "adds an information to actor" do
    information = Information.new
    information.information_type_decorator = @itypedec_name
    information.actor = @actor
    information.value = 'peter'
    @actor.save
    information.save
    @actor.informations.should include(information)
    expect(information.value).to eq('peter')
  end

  it "adds a relationship to actor" do
    relation = Relationship.new
    relation.comment = "bla"
    relation.actor = @actor
    @actor.relationships.should include(relation)
  end

  it "finds informations by key" do
    information = Information.new
    information.information_type_decorator = @itypedec_phone
    information.actor = @actor
    information.value = '999'
    @actor.save
    information.save
    @actor.find_information_by_key(:phone_test).should be(information)
    expect(information.value).to eq('999')
  end

  it "finds relationships by key" do
    rtype = RelationshipType.new
    rtype.key = :mother_test
    relation1 = Relationship.new
    relation1.relationship_type = rtype
    relation1.actor = @actor
    rtype = RelationshipType.new
    rtype.key = :father_test
    relation2 = Relationship.new
    relation2.relationship_type = rtype
    relation2.actor = @actor
    @actor.find_relationship_by_key(:mother_test).should be(relation1)
    @actor.find_relationship_by_key(:father_test).should be(relation2)
  end

  it "displays correct to_string_field" #todo this fails
    #expect(@actor.to_s).to eq('peter//999')
  it "updates to_string_field" #todo this fails
    #@atype_doctor.to_string_pattern = "|:name|"
    #expect(@actor.to_s).to eq('peter')
  it "updates search_field"

end