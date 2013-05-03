require 'spec_helper'

describe InformationFieldType do
  before do
    #create some information field types
    @emailfield = InformationFieldEmail.new
    @emailfield.key = :email_test
    @emailfield.name = 'Email'
    @emailfield.save
    @textfield = InformationFieldText.new
    @textfield.key = :text_test
    @textfield.name = 'Text'
    @textfield.save
  end

  subject{@textfield}

  it{should be_valid}
  it{should_not be_nil}

  it 'finds types by key' do
    expect(InformationFieldType.find_by_key(:email_test)).to eq(@emailfield)
    expect(InformationFieldType.find_by_key(:text_test)).to eq(@textfield)
  end

end