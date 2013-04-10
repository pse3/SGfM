require 'spec_helper'

describe Actor do
  before {
    #create an information_field_type
    information_field_text = InformationFieldText.new
    information_field_text.key = :text
    information_field_text.name_translations = { :en => 'Text field', :de => 'Textfeld', :it => '???', :fr => '???' }
    information_field_text.save

    info_company = InformationType.new
    info_company.key = :company
    info_company.information_field_type = information_field_text
    info_company.name_translations = { :en => 'Company', :de =>'Firma', :it => '??', :fr => '??' }
    info_company.save

    #create a scope
    scope_public = BlacklistScope.new
    scope_public.key = :public
    scope_public.name = 'public'
    scope_public.list = []
    scope_public.save

    #create some information_types
    itype_name = InformationType.new
    itype_name.key = :name
    itype_name.information_field_type = information_field_text
    itype_name.name = "Name"
    itype_name.scope = scope_public
    itype_name.save

    itype_phone = InformationType.new
    itype_phone.key = :phone
    itype_phone.information_field_type = information_field_text
    itype_phone.name = "Telefon"
    itype_phone.scope = scope_public
    itype_phone.save

    itype_address = InformationType.new
    itype_address.key = :address
    itype_address.information_field_type = information_field_text
    itype_address.name = "Adresse"
    itype_address.scope = scope_public
    itype_address.save

    itype_email = InformationType.new
    itype_email.key = :email
    itype_email.information_field_type = information_field_text
    itype_email.name = "Email"
    itype_email.scope = scope_public
    itype_email.save

    #create some actor_types
    @atype_doctor = ActorType.new
    @atype_doctor.name = "Arzt"
    @atype_doctor.key = :doctor
    @itypedec_name = InformationTypeDecorator.create(itype_name, @atype_doctor, true, true)
    @itypedec_phone = InformationTypeDecorator.create(itype_phone, @atype_doctor, true, true)
    InformationTypeDecorator.create(itype_address, @atype_doctor, true, true)
    InformationTypeDecorator.create(itype_email, @atype_doctor, true, true)
    @atype_doctor.save

    #create actor
    @actor = Actor.new
    @actor.actor_type = @atype_doctor
  }


  it "creates an actor" do
    @actor.should_not be_nil
    @actor.should respond_to(:actor_type)
    @actor.should respond_to(:informations)
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
    information.information_type_decorator = @itypedec_name
    information.actor = @actor
    @actor.informations.should include(information)
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
    @actor.find_information_by_key(:phone).should be(information)
  end

  it "finds relationships by key" do
    rtype = RelationshipType.new
    rtype.key = :mother
    relation1 = Relationship.new
    relation1.relationship_type = rtype
    relation1.actor = @actor
    rtype = RelationshipType.new
    rtype.key = :father
    relation2 = Relationship.new
    relation2.relationship_type = rtype
    relation2.actor = @actor
    @actor.find_relationship_by_key(:mother).should be(relation1)
    @actor.find_relationship_by_key(:father).should be(relation2)
  end

  it "displays correct to_string_field"
  it "updates to_string_field"
  it "updates search_field"

end