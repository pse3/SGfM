require 'spec_helper'

describe InformationFieldType do
  before do
    #create some information field types
    @emailfield_test = InformationFieldEmail.new
    @emailfield_test.key = :email_test
    @emailfield_test.name = 'Email'
    @emailfield_test.save
    @textfield_test = InformationFieldText.new
    @textfield_test.key = :text_test
    @textfield_test.name = 'Text'
    @textfield_test.save
  end

  describe "#informationfieldtype" do
    subject{@textfield_test}

    it{should be_valid}
    it{should_not be_nil}
  end

  describe ".find_by_key" do
    it 'finds types by key' do
      expect(InformationFieldType.find_by_key(:email_test)).to eq(@emailfield_test)
      expect(InformationFieldType.find_by_key(:text_test)).to eq(@textfield_test)
    end
  end

end