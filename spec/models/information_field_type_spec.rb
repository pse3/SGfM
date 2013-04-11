require 'spec_helper'

describe InformationFieldType do
  before {
    #create some information field types
    @emailfield = InformationFieldEmail.new
    @emailfield.key = :email_test
    @emailfield.save
    @textfield = InformationFieldText.new
    @textfield.key = :text_test
    @textfield.save
  }

  it 'finds types by key' do
    expect(InformationFieldType.find_by_key(:email_test)).to eq(@emailfield)
    expect(InformationFieldType.find_by_key(:text_test)).to eq(@textfield)
  end

end